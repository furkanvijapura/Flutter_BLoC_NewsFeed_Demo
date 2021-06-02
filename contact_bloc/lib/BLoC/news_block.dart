import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:contact_bloc/models/newsInfo_Model.dart';

enum NewsAction { fetch, delete }

class NewsBlock {
  //Pipe (logical state)
  final _stateStreamController = StreamController<List<Article>>();
  //Input
  StreamSink<List<Article>> get newsSink => _stateStreamController.sink;
  //Output
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  //Pipe (news action event)
  final _eventStreamController = StreamController<NewsAction>();
  //Input
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  //Output
  Stream<NewsAction> get eventStream => _eventStreamController.stream;

  NewsBlock() {
    eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await getNews();
          if (news != null) {
            newsSink.add(news.articles);
          } else {
            newsSink.addError('Something wents wrong');
          }
        } on Exception catch (e) {
          newsSink.addError('Something wents wrong');
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var url = Uri.parse(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=518883846ae94e6f8e70b1a02c5a2013');

      var response = await client.get(url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }

  void disposs() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}

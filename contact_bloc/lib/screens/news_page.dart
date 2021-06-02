import 'package:contact_bloc/BLoC/news_block.dart';
import 'package:contact_bloc/models/newsInfo_Model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newspage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Newspage> {
  final newsBlock = NewsBlock();

  @override
  void initState() {
    newsBlock.eventSink.add(NewsAction.fetch);
    super.initState();
  }

  @override
  void dispose() {
    newsBlock.disposs();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
        child: StreamBuilder<List<Article>>(
          stream: newsBlock.newsStream,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error as String),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data![index];
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(article.publishedAt);
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.urlToImage,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(formattedTime),
                                Text(
                                  article.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  article.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'dart:async';

enum CounterAction { counterIncreament, counterDecrement, reseteCounter }

class CounterBlock {
  //Value
  int counter = 0;

  //Pipe (logical state)
  final _stateStreamController = StreamController<int>();
  //Input
  StreamSink<int> get counterSink => _stateStreamController.sink;
  //Output
  Stream<int> get counterStream => _stateStreamController.stream;

  //Pipe (Counter action event)
  final _eventStreamController = StreamController<CounterAction>();
  //Input
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  //Output
  Stream<CounterAction> get eventStream => _eventStreamController.stream;

  CounterBlock() {
    counter = 0;
    eventStream.listen((event) {
      switch (event) {
        case CounterAction.counterIncreament:
          counter++;
          break;
        case CounterAction.counterDecrement:
          counter--;
          break;
        case CounterAction.reseteCounter:
          counter = 0;
          break;
        default:
      }

      counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}

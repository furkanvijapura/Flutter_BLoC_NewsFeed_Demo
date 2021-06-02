import 'package:contact_bloc/BLoC/counter_block.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final counterBlock = CounterBlock();

  @override
  void dispose() {
    counterBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Widgetreeee**************');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your CounterDeme"),
            StreamBuilder(
                stream: counterBlock.counterStream,
                initialData: 0,
                builder: (context, snampshot) {
                  return Text('${snampshot.data}',
                      style: Theme.of(context).textTheme.headline3);
                })
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBlock.eventSink.add(CounterAction.counterIncreament);
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBlock.eventSink.add(CounterAction.counterDecrement);
            },
            child: Icon(
              Icons.remove,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBlock.eventSink.add(CounterAction.reseteCounter);
            },
            child: Icon(Icons.loop),
          )
        ],
      ),
    );
  }
}

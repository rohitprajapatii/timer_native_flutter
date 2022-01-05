import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('stop.watch.channel');
  bool isTimerStarted = false;
  bool isReset = false;

  Stream<int> startTimer(bool reset) async* {
    while (isTimerStarted && reset != true) {
      int data = await Future.delayed(const Duration(seconds: 1),
          () async => await platform.invokeMethod('startTimer'));
      yield data;
    }
    while (reset == true) {
      int data = await platform.invokeMethod('resetTimer');
      yield data;
      setState(() {
        isReset = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop watch using platform channel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: startTimer(isReset),
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text(
                  "${snapshot.data! ~/ 60}:" "${(snapshot.data! % 60)}",
                  style: TextStyle(
                      fontSize: 130,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.6)),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(0.6),
            onPressed: () {
              setState(() {
                isTimerStarted = !isTimerStarted;
              });
            },
            tooltip: 'Start/Pause',
            child: Icon(isTimerStarted ? Icons.pause : Icons.play_arrow),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(0.6),
            onPressed: () {
              setState(() {
                isReset = true;
              });
            },
            tooltip: 'Reset',
            child: const Icon(Icons.stop),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

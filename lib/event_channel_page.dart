import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelPage extends StatefulWidget {
  const EventChannelPage({Key? key}) : super(key: key);

  @override
  State<EventChannelPage> createState() => _EventChannelPage();
}

class _EventChannelPage extends State<EventChannelPage> {
  static const EventChannel platform = EventChannel('stop.watch.event.channel');
  bool isTimerStarted = false;
  bool isReset = false;

  Stream<int> timerValue = platform.receiveBroadcastStream().cast<int>();

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
              stream: timerValue,
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

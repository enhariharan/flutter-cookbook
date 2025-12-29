import 'dart:async';

import 'package:flutter/material.dart';

class MyStopWatch extends StatefulWidget {
  const MyStopWatch({super.key});

  @override
  State<MyStopWatch> createState() => _MyStopWatchState();
}

class _MyStopWatchState extends State<MyStopWatch> {
  int seconds = 0;
  late Timer timer;
  bool isTicking = false;

  void _startTimer() {
    setState( () {
      timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() => isTicking = false);
  }

  void _onTick(Timer time) {
    if (mounted) {
      setState(() => ++seconds);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? null : _startTimer,
                child: const Text('Start'),
              ),
              const SizedBox(width: 20,),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? _stopTimer : null,
                child: const Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _secondsText() => seconds == 1 ? 'second' : 'seconds';
}

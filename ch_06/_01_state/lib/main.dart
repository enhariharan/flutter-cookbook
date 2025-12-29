import 'package:flutter/material.dart';
import 'stop_watch.dart';

void main() => runApp(const StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStopWatch(),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'stream.dart';
import 'package:flutter/material.dart';

void main() => runApp(const StreamDemoApp());

class StreamDemoApp extends StatelessWidget {
  const StreamDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StreamDemoHomePage(title: 'Flutter Stream Demo Home Page'),
    );
  }
}

class StreamDemoHomePage extends StatefulWidget {
  const StreamDemoHomePage({super.key, required this.title});

  final String title;

  @override
  State<StreamDemoHomePage> createState() => _StreamDemoHomePageState();
}

class _StreamDemoHomePageState extends State<StreamDemoHomePage> {
  late StreamSubscription _subscription;
  late StreamSubscription _subscription2;
  String _values = '';
  int _lastNumber = 0;
  late StreamController<int> _numberStreamController;
  late NumberStream _numberStream;

  late StreamTransformer _transformer;

  @override
  void initState() {
    _numberStream = NumberStream();
    _numberStreamController = _numberStream.controller;
    Stream stream = _numberStreamController.stream.asBroadcastStream();
    _subscription = stream
        .listen((event) => setState(() => _lastNumber = event));
    _subscription.onError((error) => setState(() => _lastNumber = -1));
    _subscription.onDone(() => print('_subscription: OnDone() was called'));

    _subscription2 = stream
        .listen((event) => setState(() => _values += '$event-'));
    _subscription2.onError((error) => setState(() => _lastNumber = -1));
    _subscription2.onDone(() => print('_subscription2: OnDone() was called'));

    super.initState();
  }

  @override
  void dispose() {
    _numberStream.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_lastNumber.toString()),
            Text(_values),
            ElevatedButton(
                onPressed: ()  => addRandomNumber(),
                child: Text('New Random Number')
            ),
            ElevatedButton(
                onPressed: ()  => stopStream(),
                child: Text('Stop subscription')
            ),
          ],
        ),
      ),
    );
  }

  void addRandomNumber() {
    Random random = Random();
    int num = random.nextInt(100);
    if (!_numberStreamController.isClosed) {
      _numberStream.addNumberToSink(num);
    } else {
      setState(() => _lastNumber = -1);
    }
  }

  void stopStream() => _numberStreamController.close();
}

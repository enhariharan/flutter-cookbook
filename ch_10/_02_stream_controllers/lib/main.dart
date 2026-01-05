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
      home: const StreamDemoHomePage(title: 'Flutter Demo Home Page'),
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
  int _lastNumber = 0;
  late StreamController<int> _numberStreamController;
  late NumberStream _numberStream;

  @override
  void initState() {
    _numberStream = NumberStream();
    _numberStreamController = _numberStream.controller;
    Stream stream = _numberStreamController.stream;
    stream
        .listen((event) => setState(() => _lastNumber = event))
        .onError((error) => setState(() => _lastNumber = -1));

    super.initState();
  }

  @override
  void dispose() {
    _numberStream.dispose();
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
            ElevatedButton(
                onPressed: ()  => addRandomNumber(),
                child: Text('New Random Number')
            ),
          ],
        ),
      ),
    );
  }

  void addRandomNumber() {
    Random random = Random();
    int num = random.nextInt(100);
    _numberStream.addNumberToSink(num);
    // _numberStream.addError();
  }
}

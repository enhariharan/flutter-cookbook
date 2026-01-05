import 'dart:async';

import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> _colors = [
    Colors.amber,
    Colors.blue,
    Colors.blueGrey,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1),
      (int t) => _colors[t % _colors.length],
    );
  }
}

class NumberStream {
  final StreamController<int> _controller = StreamController<int>();

  StreamController<int> get controller => _controller;

  void addNumberToSink(int number) => _controller.sink.add(number);

  void dispose() => _controller.close();

  Stream<int> getNumbers() => _controller.stream;
}
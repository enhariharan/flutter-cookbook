import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
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
      (int t) {
        int index = t % colors.length;
        return colors[index];
      },
    );
  }
}
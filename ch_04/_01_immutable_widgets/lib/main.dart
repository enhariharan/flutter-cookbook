import 'package:flutter/material.dart';

import 'immutable_widget.dart';

void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget {
  const StaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Immutable widgets demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImmutableWidget(),
    );
  }
}

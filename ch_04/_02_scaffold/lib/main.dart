import 'package:flutter/material.dart';
import 'package:_02_scaffold/basic_screen.dart';

void main() => runApp(const StaticApp());

class StaticApp extends StatelessWidget {
  const StaticApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const BasicScreen(),
    );
  }
}

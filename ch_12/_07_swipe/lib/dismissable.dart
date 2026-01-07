import 'package:flutter/material.dart';

class DismissableScreen extends StatefulWidget {
  const DismissableScreen({super.key});

  @override
  State<DismissableScreen> createState() => _DismissableScreenState();
}

class _DismissableScreenState extends State<DismissableScreen> {
  final List<String> _sweets = [
    'Petit Four',
    "Cupcake",
    'Donut',
    'Eclair',
    'Froyo',
    'Gingerbread',
    'Honeycomb',
    'Ice cream sandwich',
    'Jelly bean',
    'Kitkat',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dismissable Screen'),),
      body: ListView.builder(
        itemCount: _sweets.length,
        itemBuilder: (context, index) => Dismissible(
            key: Key(_sweets[index]),
            background: const ColoredBox(color: Colors.red),
            onDismissed: (direction) => _sweets.removeAt(index),
            child: ListTile(title: Text(_sweets[index]),),
        ),
      )
    );
  }
}

import 'package:animations/animations.dart';
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
        itemBuilder: (context, index) => OpenContainer(
          transitionDuration: const Duration(seconds: 3),
          transitionType: ContainerTransitionType.fade,
          closedBuilder: (BuildContext context, openContainer) => Dismissible(
            key: Key(_sweets[index]),
            background: const ColoredBox(color: Colors.red),
            onDismissed: (direction) => _sweets.removeAt(index),
            child: ListTile(
              title: Text(_sweets[index]),
              trailing: const Icon(Icons.cake),
              onTap: () => openContainer(),
            ),
          ),
          openBuilder: (context, closeContainer) => Scaffold(
            appBar: AppBar(title: Text(_sweets[index]),),
            body: Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 200, height: 200,
                    child: Icon(Icons.cake, size: 200, color: Colors.orange,),
                  ),
                  Text(_sweets[index]),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

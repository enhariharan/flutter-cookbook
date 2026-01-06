import 'package:flutter/material.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  final List<Color> _colors = const [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.black,
    Colors.white,
  ];
  int _iteration = 0;
  final List<double> _sizes = [100, 125, 150, 175, 200, 225, 250];
  final List<double> _tops = [0, 50, 100, 150, 200, 250, 300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Container'),
        actions: [
          IconButton(
              onPressed: () => setState(() => _iteration = (_iteration + 1) % _colors.length),
              icon: const Icon(Icons.run_circle)
          )
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          width: _sizes[_iteration],
          height: _sizes[_iteration],
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          color: _colors[_iteration],
        ),
      ),
    );
  }
}

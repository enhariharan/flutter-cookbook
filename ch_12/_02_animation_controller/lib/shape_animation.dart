import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({super.key});

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationTop;
  late Animation<double> _animationLeft;
  late double _posTop = 0;
  late double _posLeft = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationTop = Tween<double>(begin: 0, end: 300)
        .animate(_controller)
      ..addListener(() => _moveBall());
    _animationLeft = Tween<double>(begin: 0, end: 150).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Controller'),
        actions: [
          IconButton(
              onPressed: () {
                _controller.reset();
                _controller.forward();
              },
              icon: const Icon(Icons.run_circle)
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: _posLeft,
            top: _posTop,
            child: const Ball(),
          ),
        ],
      ),
    );
  }

  void _moveBall() => setState(() {
    _posTop = _animationTop.value;
    _posLeft = _animationLeft.value;
  });
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle
      ),
    );
  }
}

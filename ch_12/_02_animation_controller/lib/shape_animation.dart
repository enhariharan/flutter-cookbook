import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({super.key});

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _posTop = 0;
  late double _posLeft = 0;
  double maxTop = 0;
  double maxLeft = 0;
  final int ballSize = 100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut,);
    _animation.addListener(() => _moveBall());
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
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              maxLeft = constraints.maxWidth - ballSize;
              maxTop = constraints.maxHeight - ballSize;
              return Stack(
                children: [
                  Positioned(
                    left: _posLeft,
                    top: _posTop,
                    child: const Ball(),),
                ],
              );
            }
        ),
      ),
    );
  }

  void _moveBall() => setState(() {
    _posTop = _animation.value * maxTop;
    _posLeft = _animation.value * maxLeft;
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

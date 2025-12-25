import 'package:flutter/material.dart';

class ImmutableWidget extends StatelessWidget {
  const ImmutableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          padding: EdgeInsets.all(50.0),
          child: Container(
            color: Colors.red,
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: BlueContainer(),
            ),
          ),
        ),
      ),
    );
  }
}

class BlueContainer extends StatelessWidget {
  const BlueContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
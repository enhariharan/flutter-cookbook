import 'package:flutter/material.dart';

class ImmutableWidget extends StatelessWidget {
  const ImmutableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        padding: EdgeInsets.all(40.0),
        child: Container(
          color: Colors.yellow,
          padding: EdgeInsets.all(50.0),
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Container(
              color: Colors.red,
            ),
          ),
        )
    );
  }
}

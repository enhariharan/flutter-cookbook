import 'package:flutter/material.dart';

import 'text_layout.dart';
import 'immutable_widget.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Flutter text and rich text demo'),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.edit),
          ),

        ],
      ),
      body: Column(
        children: [
          const Center(
              child:AspectRatio(
                aspectRatio: 1.0,
                child: ImmutableWidget(),
              )
          ),
          TextLayout(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: Center(
            child: Text('This is a drawer'),
          ),
        ),
      ),
    );
  }
}


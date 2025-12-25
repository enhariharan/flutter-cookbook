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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child:AspectRatio(
                aspectRatio: 1.0,
                child: ImmutableWidget(),
              )
          ),
          Semantics(
            image: true,
            label: 'Beach image',
            child: Image.asset('assets/khachik-simonian-nXOB-wh4Oyc-unsplash.jpg'),
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


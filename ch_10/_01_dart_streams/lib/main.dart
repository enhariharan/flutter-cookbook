import 'package:_01_dart_streams/color_stream.dart';
import 'package:flutter/material.dart';

void main() => runApp(const StreamDemoApp());

class StreamDemoApp extends StatelessWidget {
  const StreamDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StreamDemoHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class StreamDemoHomePage extends StatefulWidget {
  const StreamDemoHomePage({super.key, required this.title});

  final String title;

  @override
  State<StreamDemoHomePage> createState() => _StreamDemoHomePageState();
}

class _StreamDemoHomePageState extends State<StreamDemoHomePage> {
  Color _backgroundColor = Colors.blueGrey;
  late ColorStream _colorStream;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _colorStream = ColorStream();
    _changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: _backgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _changeColor() async {
    await for (var color in _colorStream.getColors()) {
      setState(() => _backgroundColor = color);
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _documentsPath = '';
  String _tempPath = '';
  late File _file;
  String _fileText = '';

  Future _getPaths() async {
    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    setState(() {
      _documentsPath = docDir.path;
      _tempPath = tempDir.path;
    });
  }

  Future<bool> _writeFile() async {
    try {
      await _file.writeAsString('This is a test');
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    _getPaths().then((_) {
      _file = File('$_documentsPath/test.txt');
      _writeFile();
    });
    super.initState();
  }

  Future<bool> _readFile() async {
    try {
      String fileContent = await _file.readAsString();
      setState(() => _fileText = fileContent);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Documents path: $_documentsPath'),
            Text('Temp path: $_tempPath'),
            ElevatedButton(
                onPressed: () => _readFile(),
                child: Text('Read file')
            ),
            Text(_fileText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  final _storage = const FlutterSecureStorage();
  final _key = '_password';
  final _passwordController = TextEditingController();
  String _password='';

  @override
  void initState() {
    super.initState();
  }

  Future _writeToSecureStorage() async {
    await _storage.write(key: _key, value: _passwordController.text);
  }

  Future<String> _readFromSecureStorage() async {
    String secret = await _storage.read(key: _key) ?? '';
    return secret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              TextField(
                controller: _passwordController,
              ),
              ElevatedButton(onPressed: () => _writeToSecureStorage(), child: const Text('Save value')),
              ElevatedButton(onPressed: () => _readFromSecureStorage().then((v
                  ) => setState(() => _password = v)), child: const Text('Read value')),
              Text(_password),
            ],
          ),
        ),
      ),
    );
  }
}

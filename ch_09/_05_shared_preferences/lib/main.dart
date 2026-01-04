import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter SharedPreferences Demo'),
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
  int _appCounter = 0;

  Future _readAndWritePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _appCounter = prefs.getInt('_appCounter') ?? 0;
    _appCounter++;
    await prefs.setInt('_appCounter', _appCounter);
    setState(() => _appCounter = _appCounter);
  }

  @override
  void initState() {
    super.initState();
    _readAndWritePreference();
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
            const Text('You have opened the app these many times: '),
            Text(
              '$_appCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: () => _deletePreference(), child: Text('Reset counter'))
          ],
        ),
      ),
    );
  }

  Future _deletePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() => _appCounter = 0);
  }
}

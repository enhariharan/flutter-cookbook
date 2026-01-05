import 'package:flutter/material.dart';
import 'package:area/area.dart';

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
      home: PackageScreen(),
    );
  }
}

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final TextEditingController _txtWidth = TextEditingController();
  final TextEditingController _txtHeight = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _txtWidth.dispose();
    _txtHeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Package App'),),
      body: Column(
        children: [
          AppTextField(controller: _txtWidth, label: 'Width'),
          AppTextField(controller: _txtHeight, label: 'Height'),
          const Padding(padding: EdgeInsets.all(24.0)),
          ElevatedButton(
            child: const Text('Calculate Area'),
            onPressed: () {
              final width = double.tryParse(_txtWidth.text) ?? 0;
              final height = double.tryParse(_txtHeight.text) ?? 0;
              String res = calculateAreaRect(width, height);
              setState(() => _result = res);
            },
          ),
          const Padding(padding: EdgeInsets.all(24.0)),
          Text(_result),
        ],
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const AppTextField({required this.controller, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
          ),
        ),
    );
  }
}

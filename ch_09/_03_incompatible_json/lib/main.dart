import 'dart:convert';

import 'pizza.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pizzaString = '';
  List<Pizza> myPizzas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON')),
      body: ListView.builder(
        itemCount: myPizzas.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(myPizzas[index].pizzaName),
          subtitle: Text(myPizzas[index].description),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _readJsonFile().then((pizzas) => setState(() => myPizzas = pizzas));
  }

  Future<List<Pizza>> _readJsonFile() async {
    String jsonString = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/pizza_list.json');
    List pizzaMapList = jsonDecode(jsonString);
    List<Pizza> myPizzas = [];
    for (var p in pizzaMapList) {
      Pizza pizza = Pizza.fromJson(p);
      myPizzas.add(pizza);
    }

    return myPizzas;
  }
}

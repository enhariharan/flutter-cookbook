import 'dart:developer';

import 'pizza.dart';
import 'package:flutter/material.dart';

import 'http_helper.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;
  final bool isNew;
  const PizzaDetailScreen({super.key, required this.pizza, required this.isNew});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController _txtId = TextEditingController();
  final TextEditingController _txtPizzaName = TextEditingController();
  final TextEditingController _txtPizzaDescription = TextEditingController();
  final TextEditingController _txtPizzaPrice = TextEditingController();
  final TextEditingController _txtPizzaImageUri = TextEditingController();
  String _result = '';

  @override
  void initState() {
    if (!widget.isNew) {
      _txtId.text = widget.pizza.id.toString();
      _txtPizzaName.text = widget.pizza.pizzaName;
      _txtPizzaDescription.text = widget.pizza.description;
      _txtPizzaPrice.text = widget.pizza.price.toString();
      _txtPizzaImageUri.text = widget.pizza.imageUrl;
    }

    super.initState();
  }

  @override
  void dispose() {
    _txtId.dispose();
    _txtPizzaName.dispose();
    _txtPizzaDescription.dispose();
    _txtPizzaPrice.dispose();
    _txtPizzaImageUri.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Detail Screen'),),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  _result,
                  style: TextStyle(
                    backgroundColor: Colors.green[200],
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _txtId,
                    decoration: const InputDecoration(hintText: 'Insert ID'),
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _txtPizzaName,
                    decoration: const InputDecoration(hintText: 'Insert Pizza Name'),
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _txtPizzaDescription,
                    decoration: const InputDecoration(hintText: 'Insert Pizza Description'),
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _txtPizzaPrice,
                    decoration: const InputDecoration(hintText: 'Insert Pizza Price'),
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _txtPizzaImageUri,
                    decoration: const InputDecoration(hintText: 'Insert Pizza Image URI'),
                ),
                const SizedBox(height: 48,),
                ElevatedButton(
                    onPressed: () => _savePizza(),
                    child: const Text('Save'),
                ),
              ],
            ),
          ),
      ),

    );
  }

  Future _savePizza() async {
    HttpHelper httpHelper = HttpHelper();

    Pizza pizza = Pizza();
    pizza.id = int.tryParse(_txtId.text)!;
    pizza.pizzaName = _txtPizzaName.text;
    pizza.description = _txtPizzaDescription.text;
    pizza.price = double.tryParse(_txtPizzaPrice.text)!;
    pizza.imageUrl = _txtPizzaImageUri.text;

    String result = await (
      widget.isNew ? httpHelper.postPizza(pizza) : httpHelper.putPizza(pizza)
    );

    setState(() => _result = result);
  }
}

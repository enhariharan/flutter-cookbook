import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = [1, 2, 3, 4, 5];
  int counter = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (BuildContext context, int index, Animation<double> animation) =>
            fadeListTile(context, _items[index], animation),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _insertPizza(),
      ),
    );
  }

  Widget fadeListTile(BuildContext context, int item, Animation<double> animation) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
      child: Card(
        child: ListTile(
          title: Text('Pizza $item'),
          onTap: () {
            int index = _items.indexOf(item);
            if (index != -1) _removePizza(index);
          },
        ),
      ),
    );
  }

  void _removePizza(int index) {
    int removedItem = _items[index];
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => fadeListTile(context, removedItem, animation),
      duration: const Duration(seconds: 1),
    );
    _items.removeAt(index);
  }

  void _insertPizza() {
    _listKey.currentState!.insertItem(
      _items.length,
      duration: const Duration(seconds: 1),
    );
    _items.add(++counter);
  }
}

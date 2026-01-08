import 'package:flutter/material.dart';

import '../data/http_helper.dart';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Color> _bgColors = [];
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    final HttpHelper httpHelper = HttpHelper();
    httpHelper
        .getBooks('flutter')
        .then((List<Book> books) {
          setState(() => _books = books);
          int i;
          for (i=0; i<books.length; i++) {
            _bgColors.add(Colors.white);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Books'),),
      body: GridView.count(
        childAspectRatio: isLargeScreen ? 8 : 5,
        crossAxisCount: isLargeScreen ? 2 : 1,
        children: List.generate(_books.length, (index) => GestureDetector(
          onTap: () => setColor(Colors.blue, index),
          onSecondaryTap: () => setColor(Colors.white, index),
          onLongPress: () => setColor(Colors.white, index),
          child: ColoredBox(
            color: _bgColors.isNotEmpty ? _bgColors[index] : Colors.white,
            child: ListTile(
            title: Text(_books[index].title),
            subtitle: Text(_books[index].authors),
            leading: CircleAvatar(
              backgroundImage: (_books[index].thumbnail.isEmpty) ? null : NetworkImage(_books[index].thumbnail),
            ),
            ),
          ),
        )),
      ),
    );
  }

  void setColor(Color color, int index) {
    setState(() => _bgColors[index] = color);
  }

}

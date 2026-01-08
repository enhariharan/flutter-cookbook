import 'package:flutter/material.dart';

import '../data/http_helper.dart';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    final HttpHelper httpHelper = HttpHelper();
    httpHelper.getBooks('flutter').then((List<Book> books) {
      setState(() => _books = books);
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
        children: List.generate(_books.length, (index) => ListTile(
        title: Text(_books[index].title),
        subtitle: Text(_books[index].authors),
        leading: CircleAvatar(
          backgroundImage: (_books[index].thumbnail.isEmpty) ? null : NetworkImage(_books[index].thumbnail),
        ),
        )),
      ),
    );
  }
}

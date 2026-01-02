import 'package:flutter/material.dart';

import 'navigation_second.dart';

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  Color color = Colors.blue.shade700;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation first screen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => _navigateAndGetColor(context),
            child: const Text('Change color')
        ),
      ),
    );
  }

  Future _navigateAndGetColor(BuildContext context) async {
    color = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const NavigationSecond()
      ),
    ) ?? Colors.blue;
    setState(() {});
  }
}

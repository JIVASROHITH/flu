import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: WidgetsLayoutsApp()));

class WidgetsLayoutsApp extends StatelessWidget {
  const WidgetsLayoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widgets & Layouts')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome to Flutter'),
          const Icon(Icons.phone_android, size: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Home')),
              ElevatedButton(onPressed: () {}, child: const Text('About')),
            ],
          ),
        ],
      ),
    );
  }
}

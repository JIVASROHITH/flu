import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ResponsiveApp()));

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive UI')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 600
              ? const Center(child: Text('Mobile Layout'))
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Tablet/Desktop Layout'),
                    Icon(Icons.computer, size: 60),
                  ],
                );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: UserInputApp()));

class UserInputApp extends StatefulWidget {
  const UserInputApp({super.key});

  @override
  State<UserInputApp> createState() => _UserInputAppState();
}

class _UserInputAppState extends State<UserInputApp> {
  final name = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Enter Name'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hello ${name.text}!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: UpdateApp()));
}

class UpdateApp extends StatefulWidget {
  const UpdateApp({super.key});

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  final id = TextEditingController();
  final name = TextEditingController();
  final price = TextEditingController();

  @override
  void dispose() {
    id.dispose();
    name.dispose();
    price.dispose();
    super.dispose();
  }

  Future<void> updateProduct() async {
    try {
      final parsedPrice = double.parse(price.text.trim());
      await FirebaseFirestore.instance
          .collection('products')
          .doc(id.text.trim())
          .update({'name': name.text.trim(), 'price': parsedPrice});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Updated')),
      );
    } on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Price must be a valid number')),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: ${error.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: id,
              decoration: const InputDecoration(labelText: 'Document ID'),
            ),
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            ElevatedButton(
              onPressed: updateProduct,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

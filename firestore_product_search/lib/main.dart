import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: SearchApp()));
}

class SearchApp extends StatefulWidget {
  const SearchApp({super.key});

  @override
  State<SearchApp> createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {
  final search = TextEditingController();
  String query = '';

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: Column(
        children: [
          TextField(
            controller: search,
            decoration: InputDecoration(
              labelText: 'Product Name',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => query = search.text.trim()),
              ),
            ),
            onSubmitted: (value) => setState(() => query = value.trim()),
          ),
          ElevatedButton(
            onPressed: () => setState(() => query = search.text.trim()),
            child: const Text('Search'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final results = snapshot.data!.docs.where((doc) {
                  final name = doc.data()['name'];
                  return name is String &&
                      name.toLowerCase().contains(query.toLowerCase());
                });
                return ListView(
                  children: results
                      .map((doc) => ListTile(title: Text(doc.data()['name'])))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

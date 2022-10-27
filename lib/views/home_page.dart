import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/views/settings_page.dart';
import 'package:firepass/views/test_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = <String>[ 'Item 1', 'Item 2', 'Item 3', ];
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return const SettingsPage();
            }));
        }, icon: const Icon(Icons.settings)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              height: 50,
              color: Colors.black,
              child: Center(child: Text(items[index]),),
            );
          },
        ),
      ),
      );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/main.dart';
import 'package:firepass/utils.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    websiteController.text = 'https://';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 57, 63),
        child: SingleChildScrollView(
          child: Column(
          children: [
            const SizedBox(height: 120,),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: const Icon(Icons.person),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
              )
            ),
            const SizedBox(height: 30,),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
              )
            ),
            const SizedBox(height: 30,),
            TextFormField(
              controller: typeController,
              decoration: InputDecoration(
                hintText: 'Type',
                prefixIcon: const Icon(Icons.type_specimen),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
              )
            ),
            const SizedBox(height: 30,),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                prefixIcon: const Icon(Icons.abc),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
              )
            ),
            const SizedBox(height: 30,),
            TextFormField(
              controller: websiteController,
              decoration: InputDecoration(
                hintText: 'Website',
                prefixIcon: const Icon(Icons.network_cell),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
               ),
              )
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () async {
                if(await createUser(
                  name: nameController.text,
                  password: passwordController.text,
                  type: typeController.text, 
                  description: descriptionController.text, 
                  website: websiteController.text
                )) {
                  Utils.showSnackBar('Account created', SnackBarType.success);
                  navigatorKey.currentState!.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(500, 50), 
                backgroundColor: const Color.fromARGB(255, 88, 101, 242),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text('Add Account'),
            )
          ],
        ),
        )
      ),
    );
  }

  Future<bool> createUser(
    {
      required String name,
      required String password,
      required String type,
      required String description,
      required String website
    }
  ) async {
    if(Uri.tryParse(website) == null) {
      Utils.showSnackBar('Invalid URL entered', SnackBarType.error);
      return false;
    }
    final user = FirebaseAuth.instance.currentUser!;
    final userdoc = FirebaseFirestore.instance
      .collection(user.uid)
      .doc();

    final data = {
      'id': userdoc.id,
      'name': name,
      'password': password,
      'type': type,
      'description': description,
      'website': website
    };

    await userdoc.set(data);
    return true;
  }
}
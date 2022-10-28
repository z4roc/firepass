import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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



    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Account'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 57, 63),
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
            OutlinedButton(
                onPressed: (){
                createUser(
                  name: nameController.text,
                  password: passwordController.text,
                  type: typeController.text, 
                  description: descriptionController.text, 
                  website: websiteController.text
                );
              },
              child: const Text('Add Account'),
            )
          ],
        ),
      ),
    );
  }

  Future createUser(
    {
      required String name,
      required String password,
      required String type,
      required String description,
      required String website
    }
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userdoc = FirebaseFirestore.instance
      .collection(user.uid)
      .doc(DateTime.now().millisecondsSinceEpoch.toString());

    final data = {
      'name': name,
      'password': password,
      'type': type,
      'description': description,
      'website': website
    };

    await userdoc.set(data);

  }
}
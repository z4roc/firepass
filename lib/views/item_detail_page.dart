import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/main.dart';
import 'package:firepass/utils.dart';
import 'package:flutter/material.dart';
import '../models/account_model.dart';

class ItemDetailPage extends StatefulWidget {
  final Account selectedAccount;

  const ItemDetailPage({super.key, required this.selectedAccount});
  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final typeController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final descriptionController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final account = widget.selectedAccount;
    typeController.text = account.type;
    nameController.text = account.name;
    passwordController.text = account.password;
    descriptionController.text = account.description;
    websiteController.text = account.website;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: const Color.fromARGB(255, 32, 34, 37),
        actions: [
          IconButton(onPressed: () {
            saveAccount(account.id);
            navigatorKey.currentState!.pop();
            Utils.showSnackBar('${account.type} Account ${account.name} updated', SnackBarType.success);
          }, icon: const Icon(Icons.save_sharp)),
        ],
        ),
        backgroundColor: const Color.fromARGB(255, 54, 57, 63),
        body: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40,),
                Image(image: 
                 NetworkImage('https://www.google.com/s2/favicons?sz=64&domain_url=${account.website.split('//')[1]}'),
                 height: 75,),
                const SizedBox(height: 30,),
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

              ],
            ),
          )
        ),
      );
  }

  Future saveAccount(String accountId) async {
    final userdoc = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(accountId);
    
    userdoc.update({
      'id': accountId,
      'name': nameController.text,
      'password': passwordController.text,
      'type': typeController.text,
      'description': descriptionController.text,
      'website': websiteController.text
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/models/account_model.dart';
import 'package:firepass/views/add_item_page.dart';
import 'package:firepass/views/settings_page.dart';
import 'package:firepass/views/test_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 57, 63),
      appBar: AppBar(
        title: Text(user.displayName!),
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return const SettingsPage();
            }));
        }, icon: const Icon(Icons.settings)),
        backgroundColor: const Color.fromARGB(255, 32, 34, 37),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddPage();
          },));
        },
        backgroundColor: const Color.fromARGB(255, 88, 101, 242),
        child: const Icon(Icons.add, color: Colors.white), 
      ),
      body: Center(
        child: StreamBuilder<List<Account>>(
          stream: readAccounts(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final accounts = snapshot.data!;
              return ListView(
                children: accounts.map(buildAccount).toList(),
              );
            }
            else if(snapshot.hasError) {
              return const Text('Error retrieving data!');
            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        )
      ),
    );
  }

  Widget buildAccount(Account account) => Card(
    color: const Color.fromARGB(255, 60, 63, 69),
    child: ListTile(
      leading: Image(
        image: NetworkImage('https://www.google.com/s2/favicons?sz=64&domain_url=${account.website.split('//')[1]}'),
        height: 40,
      ),
      title: Text(account.name),
      subtitle: Text(account.type),
    ),
  );

  Stream<List<Account>> readAccounts() => FirebaseFirestore.
    instance.collection(FirebaseAuth.instance.currentUser!.uid)
    .snapshots()
    .map((snapshot) => 
      snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList());

}
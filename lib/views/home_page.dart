import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/models/account_model.dart';
import 'package:firepass/utils.dart';
import 'package:firepass/views/add_item_page.dart';
import 'package:firepass/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import 'item_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 54, 57, 63),
      appBar: AppBar(
        title: const Text('Firepass'),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.of(context).push(PageTransition(
            childCurrent: this,
            child: const SettingsPage(),
            type: PageTransitionType.leftToRightJoined
            )
          );
        }, icon: const Icon(Icons.settings)),
        backgroundColor: const Color.fromARGB(255, 32, 34, 37),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(PageTransition(
            child: const AddPage(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 400),
            reverseDuration: const Duration(milliseconds: 400)
            )
          );
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

  Widget buildAccount(Account account) => Slidable(
    startActionPane: ActionPane(
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (context) async {
            await Clipboard.setData(ClipboardData(text: account.password));
            Utils.showSnackBar('Copied password to clipboard', SnackBarType.success);
          },
          icon: Icons.copy,
          backgroundColor: const Color.fromARGB(255, 88, 101, 242),
          flex: 1,
        ),
        SlidableAction(
          onPressed: (context) async {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text('Password for ${account.name}'),
                content: Text(account.password),
                actions: [
                  ElevatedButton(onPressed: () {
                    navigatorKey.currentState!.pop();
                  },
                  child: const Text('Close'))
                ],
              );
            },);
          },
          icon: Icons.remove_red_eye,
          backgroundColor: const Color.fromARGB(255, 88, 101, 242),
          flex: 1,
        )
      ]
    ),
    endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text('Are you sure you want to delete this account?'),
                  actions: [
                    ElevatedButton(onPressed: (){
                      navigatorKey.currentState!.pop();
                    }, 
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                      backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 88, 101, 242))
                      ),
                    child: const Text('Cancel'),
                    ),
                    ElevatedButton(onPressed: () {
                      deleteAccount(account);
                    },
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                      backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 253, 69, 86))
                      ), 
                    child: const Text('Yes'),)
                  ],
                );
              },
            );
          },
          icon: Icons.delete,
          backgroundColor: const Color.fromARGB(255, 254, 69, 86),  
        ),
      ]
    ),
    child: ListTile(
      leading: Image(
        image: NetworkImage('https://www.google.com/s2/favicons?sz=64&domain_url=${account.website.split('//')[1]}'),
        height: 40,
      ),
      title: Text(account.name),
      subtitle: Text(account.type),
      onTap: () {
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) {
          return ItemDetailPage(selectedAccount: account);
        },));
      },
    ),
  );

  Stream<List<Account>> readAccounts() => FirebaseFirestore.
    instance.collection(FirebaseAuth.instance.currentUser!.uid)
    .snapshots()
    .map((snapshot) => 
      snapshot.docs.map((doc) => Account.fromJson(doc.data())).toList());
  
  Future deleteAccount (Account account) async {
    final userdoc = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc(account.id);
    userdoc.delete();
    navigatorKey.currentState!.pop();
    Utils.showSnackBar('${account.type} Account ${account.name} deleted', SnackBarType.error);
  }
}
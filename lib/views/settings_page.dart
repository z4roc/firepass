import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepass/main.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 60, 63, 69),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            const Text('Logged in as'),
            Text(user.email!, style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                navigatorKey.currentState!.pop();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(500, 50), 
                backgroundColor: const Color.fromARGB(255, 88, 101, 242),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text('Log out'),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!.delete();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(500, 50), 
                backgroundColor: const Color.fromARGB(255, 253, 69, 86),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text('Delete account', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),),
            )

          ],
        ),
      ),
    );
  }
}
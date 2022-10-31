import 'package:firepass/main.dart';
import 'package:firepass/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 32, 34, 37),
      ),
      backgroundColor: const Color.fromARGB(255, 54, 57, 63),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset('images/blue.png', height: 100),
            const SizedBox(height: 10,),
            const Text('Register at FirePass', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            TextFormField(
              controller: username,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-Mail',
                prefixIcon: const Icon(Icons.person),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: (){
                registerAccount();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(500, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: const Text('Register now', style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }

  Future registerAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: username.text, password: password.text);
      navigatorKey.currentState!.pop();
      Utils.showSnackBar('Successfully registered', SnackBarType.success);
    } on FirebaseAuthException catch(e) {
      Utils.showSnackBar(e.message, SnackBarType.error);
      return;
    }
  }
}

import 'package:firepass/main.dart';
import 'package:firepass/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromARGB(255, 54, 57, 63),
      child: Column(children: [
        const SizedBox(height: 120,),
        const Text(
          'Sign in',
           style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
           ),
        ),
        const SizedBox(height: 60,),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'E-Mail',
            prefixIcon: const Icon(Icons.person),
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),

            ),
          ),
        ),
        const SizedBox(height: 30,),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(onPressed: signIn, child: const Text('Login')),
        const SizedBox(height: 5,),
        TextButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return const RegisterPage();
            }));
          }, 
          child: const Text('No account? Register now')
        )
      ]),
    );
  }

  Future signIn() async {
    /*showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()));*/

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch(e) {
      print(e);
    }

    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
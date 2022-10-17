import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          decoration: InputDecoration(
            hintText: 'Username',
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
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

      ]),
    );
  }
}
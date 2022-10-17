import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subpage'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Image.asset('images/a.jpg'),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            color: Colors.deepOrange,
            width: double.infinity,
            child: const Center(
              child: Text('Test', style: TextStyle(color: Colors.white)),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Button'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Button'),
          ),
        ],
      ),
    );
  }
}

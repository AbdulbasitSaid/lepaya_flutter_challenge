import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lepaya Assignment',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lepaya Assignment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Text('Hey there! Welcome to the Lepaya Flutter assignment.'),
              SizedBox(height: 16),
              Text(
                'Check the `readme` of this repository for the instructions.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лабораторная работа 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шолохов Роман Юрьевич'), 
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Wrap(
          spacing: 16.0,     
          runSpacing: 16.0,   
          alignment: WrapAlignment.center, 
          children: [
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.red,
            ),
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.green,
            ),
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.blue,
            ),
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.orange,
            ),
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.purple,
            ),
            Container(
              width: 120,
              height: 120,
              margin: const EdgeInsets.all(8.0),
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
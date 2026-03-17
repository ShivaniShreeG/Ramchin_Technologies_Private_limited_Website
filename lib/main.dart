import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyWebApp());
}

class MyWebApp extends StatelessWidget {
  const MyWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramchin Technologies Private Limited',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


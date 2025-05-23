import 'package:flutter/material.dart';
import 'screens/news_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Новости КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const NewsScreen(),
    );
  }
}
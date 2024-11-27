import 'package:flutter/material.dart';
import './home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqflite App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:  const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67)
      ),
      home: const HomePage(title: 'Sqflite App')
    );
  }
}
import 'package:flutter/material.dart';
import 'form_page.dart';
import 'display_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Data Diri',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FormPage(),
        '/display': (context) => DisplayPage(),
      },
    );
  }
}

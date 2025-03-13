import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/login_page.dart';

void main() {
  runApp(const ScholarApp());
}

class ScholarApp extends StatelessWidget {
  const ScholarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar App',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/registeration_page.dart';

void main() {
  runApp(const ScholarApp());
}

class ScholarApp extends StatelessWidget {
  const ScholarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterationPage.id: (context) => RegisterationPage(),
      },
      title: 'Scholar App',
      initialRoute: 'LoginPage',
      debugShowCheckedModeBanner: false,
    );
  }
}

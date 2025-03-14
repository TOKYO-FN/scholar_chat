import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/registeration_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Scholar app"),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.amber[400]!,
              Colors.amber[300]!,
              Colors.amber[200]!,
              Colors.amber[100]!,
              Colors.amber[100]!,
              Colors.amber[100]!,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              Spacer(),
              Image.asset('assets/images/scholar.png'),
              Text(
                'Scholar Chat',
                style: TextStyle(fontSize: 32, fontFamily: 'Pacifico'),
              ),
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontFamily: 'Pacifico'),
              ),
              SizedBox(height: 10),
              CustomTextField(label: 'Email'),
              SizedBox(height: 5),
              CustomTextField(label: 'Password'),
              SizedBox(height: 10),

              CustomButton(label: 'Login'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account "),
                  GestureDetector(
                    onTap:
                        () =>
                            Navigator.pushNamed(context, RegisterationPage.id),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.amber.shade500),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

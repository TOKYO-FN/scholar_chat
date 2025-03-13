import 'package:flutter/material.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Scholar app"), backgroundColor: Colors.amber),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/images/scholar.png'),
            Text(
              'Scholar Chat',
              style: TextStyle(fontSize: 32, fontFamily: 'Pacifico'),
            ),
            Row(children: [Text('Sign In', style: TextStyle(fontSize: 24))]),
            SizedBox(height: 10),
            CustomTextField(label: 'Email'),
            SizedBox(height: 5),
            CustomTextField(label: 'Password'),
            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[200], // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // Rounded corners
                  ),
                ),
                onPressed: () {
                  // Add navigation or logic here
                },
                child: Text('Sign in', style: TextStyle(color: Colors.black)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("don't have an account "),
                Text(
                  'Register',
                  style: TextStyle(color: Colors.amber.shade500),
                ),
              ],
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

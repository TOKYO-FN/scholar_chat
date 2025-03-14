import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class RegisterationPage extends StatelessWidget {
  RegisterationPage({super.key});
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  static String id = 'RegisterationPage';

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
          child: Form(
            key: formKey,

            child: ListView(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/images/scholar.png', height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(fontSize: 32, fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(fontSize: 24, fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomTextField(
                  label: 'Email',
                  onChanged: (data) => email = data,
                ),
                SizedBox(height: 5),
                CustomTextField(
                  label: 'Password',
                  onChanged: (data) => password = data,
                ),
                SizedBox(height: 10),

                CustomButton(
                  label: 'Sign up',
                  fun: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await registerUser();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            'The password provided is too weak',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            'The account already exists for that email',
                          );
                        }
                      }
                      showSnackBar(context, 'Success!');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account "),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.amber.shade500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}

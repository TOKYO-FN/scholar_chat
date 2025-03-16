import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/registeration_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                        'Login',
                        style: TextStyle(fontSize: 24, fontFamily: 'Pacifico'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    label: 'Email',
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: 'Password',
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(height: 10),

                  CustomButton(
                    label: 'Login',
                    fun: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          showSnackBar(context, 'Success!');
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              context,
                              'No user found for that email',
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              'Wrong password provided for that user',
                            );
                          }
                        } catch (e) {
                          print(e);
                          showSnackBar(context, 'An error occurred');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("don't have an account "),
                      GestureDetector(
                        onTap:
                            () => Navigator.pushNamed(
                              context,
                              RegisterationPage.id,
                            ),
                        child: Text(
                          'Register',
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
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

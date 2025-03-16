import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        appBar: AppBar(backgroundColor: kPrimaryColor, elevation: 0),
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
                  SizedBox(height: 60),

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

                  SizedBox(height: 50),

                  CustomTextField.CustomTextFormField(
                    label: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),

                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField.CustomTextFormField(
                    isPassword: true,

                    label: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    postFixIcon: Icon(Icons.remove_red_eye_outlined),

                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  SizedBox(height: 14),

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
                          switch (e.code) {
                            case 'invalid-email':
                              showSnackBar(
                                context,
                                "Invalid email please check your email",
                              );
                            case 'invalid-credential':
                              showSnackBar(
                                context,
                                "Invalid email or password",
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
                  SizedBox(height: 10),

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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/helper/show_snack_bar.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_text_field.dart';

class RegisterationPage extends StatefulWidget {
  const RegisterationPage({super.key});
  static String id = 'RegisterationPage';

  @override
  State<RegisterationPage> createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
  bool obsecureText = true;

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
                    onChanged: (data) {
                      email = data;
                      print(email);
                    },
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 10),
                  CustomTextField.CustomTextFormField(
                    isPassword: obsecureText,
                    onChanged: (data) {
                      password = data;
                      print(password);
                    },

                    label: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    postFixIcon: IconButton(
                      onPressed: () {
                        obsecureText = !obsecureText;
                        setState(() {});
                      },
                      icon:
                          obsecureText
                              ? Icon(CupertinoIcons.eye_slash)
                              : Icon(CupertinoIcons.eye),
                    ),
                  ),
                  SizedBox(height: 14),

                  CustomButton(
                    label: 'Sign up',
                    fun: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await registerUser();
                          Navigator.pushNamed(context, LoginPage.id);
                          showSnackBar(context, 'Success!');
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
                        } catch (e) {
                          showSnackBar(context, 'An error occurred, $e');
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
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}

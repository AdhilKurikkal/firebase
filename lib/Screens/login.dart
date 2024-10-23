import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseui/Screens/home.dart';
import 'package:firebaseui/Screens/sign.dart';
import 'package:firebaseui/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class loginView extends StatefulWidget {
  const loginView({super.key});

  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  authGet() async {
    if (emailController.text == '') {
      showUploadMessage('Enter your email', context);
    }
    if (passwordController.text == '') {
      showUploadMessage('Enter Your password', context);
    }
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: emailController.text)
        .get();
    if (data.docs.isEmpty) {
      showUploadMessage('User does not found', context);
    } else {
      if (data.docs[0]['password'] == passwordController.text) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } else {
        showUploadMessage('Wrong password', context);
      }
    }
  }

  //googlesign
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUSer = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUSer?.authentication;
    if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  final formKey = GlobalKey<FormState>();
  bool eye = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Firebase',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.065,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(w * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.05,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.03)),
                          counterText: '',
                        ),
                      ),
                      SizedBox(
                        height: h * 0.04,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: eye ? true : false,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(w * 0.03)),
                          counterText: '',
                          suffixIcon: InkWell(
                              onTap: () {
                                eye = !eye;
                                setState(() {});
                              },
                              child: eye
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white,
                                    )),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: h * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              authGet();

                              // FirebaseAuth.instance
                              //     .signInWithEmailAndPassword(
                              //         email: emailController.text,
                              //         password: passwordController.text)
                              //     .then(
                              //       (value) => Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => HomePage(),
                              //         ),
                              //       ),
                              //     )
                              //     .catchError((e) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(e.toString()),
                              //     ),
                              //   );
                              // });
                            },
                            child: Container(
                              height: h * 0.065,
                              width: w * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(w * 0.08),
                                  border: Border.all(
                                      width: w * 0.005, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.04,
                          ),
                          InkWell(
                            onTap: () {
                              //googlesign

                              signInWithGoogle(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            },
                            child: Container(
                              height: h * 0.065,
                              width: w * 0.6,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(w * 0.08),
                                  border: Border.all(
                                      width: w * 0.005, color: Colors.black)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.04),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignScreen(),
                                  ));
                            },
                            child: Text(
                              'Sign',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  showUploadMessage(String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}

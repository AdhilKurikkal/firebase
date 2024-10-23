import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebaseui/Screens/home.dart';
import 'package:firebaseui/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  File? file;
  String imgUrl =
      'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=';

  pickFile(ImageSource) async {
    final imgfile = await ImagePicker().pickImage(source: ImageSource);
    file = File(imgfile!.path);

    if (mounted) {
      setState(() {});
    }
    Navigator.pop(context);
    print(file);
    uploadFile(file!);
  }

//storage

  // uploadFile(File file) async {
  //   var uploadTask = await FirebaseStorage.instance
  //       .ref('images')
  //       .child(DateTime.now().toString())
  //       .putFile(file);
  // var getDownloadUrl = await uploadTask.ref.getDownloadURL();
  //   print(getDownloadUrl);
  //   imgUrl = getDownloadUrl;
  //   setState(() {});
  // }

  uploadFile(File file) async {
    var uploadTask = await FirebaseStorage.instance
        .ref('displayPicture')
        .child(DateTime.now().toString())
        .putFile(file);
    var getDownloadUrl = await uploadTask.ref.getDownloadURL();
    imgUrl = getDownloadUrl;
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'SignIn',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Stack(children: [
                Container(
                  height: h * 0.16,
                  width: w * 1,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(imgUrl),
                        radius: w * 0.159,
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: w * 0.368,
                  top: w * 0.268,
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('Photo Gallery'),
                                  onPressed: () {
                                    // pickFile(ImageSource.gallery);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text('Camera'),
                                  onPressed: () {
                                    // pickFile(ImageSource.camera);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: w * 0.04,
                      child: InkWell(
                        onTap: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(ImageSource.gallery);
                                      // Navigator.pop(context);
                                    },
                                    child: Text('Photo Gallery'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      pickFile(
                                        ImageSource.camera,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text('Camera'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: h * 0.06,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: nameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: 'name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter your name',
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
              // obscureText: eye ? true : false,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.03)),
                counterText: '',
                suffixIcon: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off,
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
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(emailController.text.trim())
                          .set({
                        "name": nameController.text,
                        "email": emailController.text.trim(),
                        "password": passwordController.text,
                        "image": imgUrl
                      });

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }).catchError((e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    });
                  },
                  child: Container(
                    height: h * 0.065,
                    width: w * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(w * 0.08),
                        border:
                            Border.all(width: w * 0.005, color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'SignUp',
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
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

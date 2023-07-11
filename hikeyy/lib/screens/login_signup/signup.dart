import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/login_signup/verify_mail.dart';

import '../../widgets/app_texts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _signupform = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _signupform,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: SizedBox(
                          height: 200,
                          child: Image.asset('assets/images/logo.png'))),
                  const AppTextHeading(
                    textHeading: 'Sign Up',
                    fontSize: 35,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Create a new account',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppText(text: 'User Name'),
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppText(text: 'Email'),
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppText(text: 'Password'),
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppText(text: 'Confirm Password'),
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: _confirmpasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cant be empty';
                        }
                        if (value != _passwordController.text) {
                          return 'Password Doesn\'t match';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 209, 207, 207)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45.0),
                      child: Center(
                        child: SizedBox(
                          width: 400,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_signupform.currentState!.validate()) {
                                _signupform.currentState!.save();
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim())
                                    .then((value) {
                                  users.doc(value.user!.uid).set({
                                    'Bio': '',
                                    'pfpUrl': 'https://firebasestorage.googleapis.com/v0/b/hikeyyy.appspot.com/o/Pfp%2Fprofile.png?alt=media&token=69ba79e5-7f39-41bd-9bd1-b4b509e5e0f3',
                                    'UserName': _nameController.text.trim(),
                                    'Email': _emailController.text.trim(),
                                  }).then((value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const VerifyMailPage()),
                                    );
                                  });
                                }).onError((error, stackTrace) {
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text('Error'),
                                            content: Text(error.toString()),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(58, 78, 47, 1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Login',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

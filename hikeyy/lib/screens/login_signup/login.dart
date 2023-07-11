import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/login_signup/is_logged_in.dart';
import 'package:hikeyy/screens/login_signup/signup.dart';

import '../../widgets/app_texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future signIN() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IsLogged()),
      );
    }).onError((error, stackTrace) async {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: SizedBox(
                    height: 250,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fill,
                    )),
              ),
              const AppTextHeading(
                textHeading: 'Welcome!',
                fontSize: 25,
              ),
              const Text(
                'Please login or signup to continue our app',
                style: TextStyle(color: Colors.grey),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: AppText(text: 'Email'),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 209, 207, 207)),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: AppText(text: 'Password'),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 209, 207, 207)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        signIN();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Signup()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppin'),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

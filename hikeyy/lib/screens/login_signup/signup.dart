import 'package:flutter/material.dart';

import '../../widgets/app_texts.dart';
import '../dashboard/dashboard.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final ValueNotifier<bool> _iAgreeCheckboxValue = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                        height: 200,
                        child: Image.asset('assets/images/logo.png'))),
                AppTextsHeading(
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
                AppText(text: 'User Name'),
                SizedBox(
                  height: 30,
                  child: TextFormField(
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
                AppText(text: 'Email'),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 209, 207, 207)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(text: 'Password'),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 209, 207, 207)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(text: 'Confirm Password'),
                SizedBox(
                  height: 30,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
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
                          child: Text(
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
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/app_buttons.dart';
import '../widgets/app_texts.dart';

class Expenses extends StatefulWidget {
  final String id;
  const Expenses({Key? key, required this.id}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  bool showfield=false;
  final _eform =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            showfield?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _eform,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: AppText(text: 'Title'),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                       // controller: _emailController,
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
                      child: AppText(text: 'Amount'),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                       // controller: _passwordController,
                        //obscureText: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Color.fromARGB(255, 209, 207, 207)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ):Container(),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: AppButtons(
                  onPressed: () {
                    setState(() {
                      showfield=true;
                    });
                  },
                  child: const AppText(
                    text: 'Expenses',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

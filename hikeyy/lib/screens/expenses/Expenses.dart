import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';

import '../../widgets/app_buttons.dart';
import '../../widgets/app_texts.dart';

class Expenses extends StatefulWidget {
  final String id;
  const Expenses({Key? key, required this.id}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final int cardCount = 2;
  int currentPageIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  bool showfield = false;
  final _eform = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ], shape: BoxShape.circle, color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: SizedBox(
                    height: 300,
                    child: PageView.builder(
                        padEnds: false,
                        controller: PageController(viewportFraction: 0.9),
                        itemCount: 2,
                        onPageChanged: onPageChanged,
                        itemBuilder: ((context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 163, 226, 167),
                                      Colors.white,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: 'Total Trip Expenses:',
                                        fontSize: 15,
                                      ),
                                      AppText(
                                        text: 'Rs. 2000',
                                        fontSize: 25,
                                      )
                                    ]),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 300,
                                width: 300,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 163, 226, 167),
                                      Colors.white,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppText(
                                        text: 'My Trip Expenses:',
                                        fontSize: 15,
                                      ),
                                      AppText(
                                        text: 'Rs. 200',
                                        fontSize: 25,
                                      )
                                    ]),
                              ),
                            );
                          }
                        })),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(cardCount, (int index) {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPageIndex == index
                                ? AppColor.primaryColor
                                : Colors.grey),
                      );
                    }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20),
                  child: AppText(
                      text: 'Transaction History',
                      fontSize: 20,
                      color: AppColor.primaryDarkColor),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                      child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          subtitle: Row(
                            children: [
                              AppText(
                                text: 'Made By: ',
                              ),
                              AppText(text: 'Pritisha')
                            ],
                          ),
                          leading: Icon(Icons.money_off),
                          title: AppText(
                            text: 'Dinner',
                            fontSize: 20,
                          ),
                          trailing: AppText(
                            text: 'Rs. 1000',
                            fontSize: 17,
                            color: AppColor.primaryDarkColor,
                          ),
                        ),
                      );
                    },
                  )),
                ),
                showfield
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _eform,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: AppText(
                                  text: 'Title',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  // controller: _emailController,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 209, 207, 207)),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: AppText(
                                  text: 'Amount',
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  // controller: _passwordController,
                                  //obscureText: true,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 209, 207, 207)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 35),
                  child: Center(
                    child: AppButtons(
                        onPressed: () {
                          setState(() {
                            showfield = true;
                          });
                        },
                        child: const AppText(
                          text: 'Add Expenses',
                        )),
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

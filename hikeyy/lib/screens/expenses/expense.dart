
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<String> getUserName(String id) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    return data.get('UserName');
  }

  Widget expenses(String? ID) {
    return StreamBuilder<QuerySnapshot>(
        stream: ID != null
            ? FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Expenses')
                .where('PaidBy', isEqualTo: ID)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Expenses')
                .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          double totalExpenses = 0;
          for (var element in snapshots.data!.docs) {
            var data = element.data() as Map<String, dynamic>;
            double expenses = double.parse(data['Amount'].toString());
            totalExpenses = totalExpenses + expenses;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ID != null
                        ? FutureBuilder<String>(
                            future: getUserName(ID!),
                            builder: (context, data) {
                              if (data.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return AppText(
                                text: 'Expenses Of ${data.data!}',
                                fontSize: 15,
                              );
                            })
                        : const AppText(
                            text: 'Total Trip Expenses:',
                            fontSize: 15,
                          ),
                    AppText(
                      text: 'Rs. ${totalExpenses.toString()}',
                      fontSize: 25,
                    )
                  ]),
            ),
          );
        });
  }

  // Future<double> getTotalExpenses() async {
  //   double expenses = 0 ;
  //   Stream<QuerySnapshot> data = FirebaseFirestore.instance.collection('Groups').doc(widget.id).collection('Expenses').snapshots();
  //   data.da
  //   data.forEach((element) {
  //     expenses = expenses+ double.parse(element);
  //   });
  // }
  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  bool showfield = false;
  final _eform = GlobalKey<FormState>();
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _amountController = new TextEditingController();

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
                  child: const Padding(
                    padding: EdgeInsets.only(
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
                    child: FutureBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('Groups')
                            .doc(widget.id)
                            .get(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          var data = snapshot.data!.data();
                          List members = data!['Members'];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              height: 310,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                  // physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: members.length + 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (index == 0) {
                                      return expenses(null);
                                    } else {
                                      return expenses(members[index - 1]);
                                    }
                                  }),
                            ),
                          );
                        }),

                    // PageView.builder(
                    //     padEnds: false,
                    //     controller: PageController(viewportFraction: 0.9),
                    //     itemCount: 2,
                    //     onPageChanged: onPageChanged,
                    //     itemBuilder: ((context, index) {
                    //       if (index == 0) {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(10.0),
                    //           child:
                    //           Container(
                    //             height: 300,
                    //             width: 300,
                    //             decoration: BoxDecoration(
                    //               gradient: const LinearGradient(
                    //                 begin: Alignment.topCenter,
                    //                 end: Alignment.bottomCenter,
                    //                 colors: [
                    //                   Color.fromARGB(255, 163, 226, 167),
                    //                   Colors.white,
                    //                 ],
                    //               ),
                    //               borderRadius: BorderRadius.circular(30),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey.withOpacity(0.5),
                    //                   spreadRadius: 3,
                    //                   blurRadius: 6,
                    //                   offset: const Offset(0, 2),
                    //                 ),
                    //               ],
                    //             ),
                    //             child: const Column(
                    //                 crossAxisAlignment:
                    //                 CrossAxisAlignment.center,
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   AppText(
                    //                     text: 'Total Trip Expenses:',
                    //                     fontSize: 15,
                    //                   ),
                    //                   AppText(
                    //                     text: 'Rs. 2000',
                    //                     fontSize: 25,
                    //                   )
                    //                 ]),
                    //           ),
                    //         );
                    //       } else {
                    //         return Padding(
                    //           padding: const EdgeInsets.all(10.0),
                    //           child: Container(
                    //             height: 300,
                    //             width: 300,
                    //             decoration: BoxDecoration(
                    //               gradient: const LinearGradient(
                    //                 begin: Alignment.topCenter,
                    //                 end: Alignment.bottomCenter,
                    //                 colors: [
                    //                   Color.fromARGB(255, 163, 226, 167),
                    //                   Colors.white,
                    //                 ],
                    //               ),
                    //               borderRadius: BorderRadius.circular(30),
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: Colors.grey.withOpacity(0.5),
                    //                   spreadRadius: 3,
                    //                   blurRadius: 6,
                    //                   offset: const Offset(0, 2),
                    //                 ),
                    //               ],
                    //             ),
                    //             child: const Column(
                    //                 crossAxisAlignment:
                    //                 CrossAxisAlignment.center,
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   AppText(
                    //                     text: 'My Trip Expenses:',
                    //                     fontSize: 15,
                    //                   ),
                    //                   AppText(
                    //                     text: 'Rs. 200',
                    //                     fontSize: 25,
                    //                   )
                    //                 ]),
                    //           ),
                    //         );
                    //       }
                    //     })),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List<Widget>.generate(cardCount, (int index) {
                //       return Container(
                //         padding: const EdgeInsets.all(3),
                //         margin: const EdgeInsets.symmetric(horizontal: 2),
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: currentPageIndex == index
                //                 ? AppColor.primaryColor
                //                 : Colors.grey),
                //       );
                //     }),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20),
                  child: AppText(
                      text: 'Transaction History',
                      fontSize: 20,
                      color: AppColor.primaryDarkColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Groups')
                            .doc(widget.id)
                            .collection('Expenses')
                            .orderBy('Time', descending: true)
                            .snapshots(),
                        builder: (context, snapshots) {
                          if (snapshots.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshots.hasData) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshots.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                String title = data['Title'];
                                String user = data['PaidBy'];
                                DateTime time =data['Time'].toDate();
                                return Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const AppText(
                                                  text: 'Made By: ',
                                                ),
                                                FutureBuilder<String>(
                                                    future: getUserName(user),
                                                    builder: (context, data) {
                                                      if (data.connectionState ==
                                                          ConnectionState.waiting) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                      return AppText(text: data.data!);
                                                    }),

                                              ],
                                            ),
                                            AppText(text: '${time.year}|${time.month}|${time.day} ${time.hour}:${time.minute}')
                                          ],
                                        ),
                                        leading: const Icon(Icons.money_off),
                                        title: AppText(
                                          text: title,
                                          fontSize: 20,
                                        ),
                                        trailing: AppText(
                                          text: 'Rs.${data['Amount']}',
                                          fontSize: 17,
                                          color: AppColor.primaryDarkColor,
                                        ),
                                      ),
                                    ),

                                  ],
                                );
                              },
                            );
                          }
                          return Container();
                        }),
                  ),
                ),
                showfield
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _eform,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showfield = false;
                                        });
                                      },
                                      icon: Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.primaryColor),
                                        child:
                                            const Icon(Icons.transit_enterexit),
                                      )),
                                ),
                              ),
                              const AppText(
                                text: 'Title',
                                fontSize: 20,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  controller: _titleController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cant be empty';
                                    }
                                    return null;
                                  },
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
                                  controller: _amountController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cant be empty';
                                    }
                                    return null;
                                  },
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
                        onPressed: () async {
                          showfield == false
                              ? setState(() {
                                  showfield = true;
                                })
                              : {
                                  if (_eform.currentState!.validate())
                                    {
                                      _eform.currentState!.save(),
                                      FirebaseFirestore.instance
                                          .collection('Groups')
                                          .doc(widget.id)
                                          .collection('Expenses')
                                          .add({
                                        'Title': _titleController.text
                                            .trim()
                                            .toString(),
                                        'Amount': _amountController.text
                                            .trim()
                                            .toString(),
                                        'Time': DateTime.now(),
                                        'PaidBy': FirebaseAuth
                                            .instance.currentUser!.uid
                                      }).then((value) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget));
                                      })
                                    }
                                };
                        },
                        child: AppText(
                          text: showfield == false ? 'Add Expenses' : 'Submit',
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

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../login_signup/is_in_trip.dart';

class EndTripDetails extends StatefulWidget {
  final String id;

  const EndTripDetails({super.key, required this.id});

  @override
  State<EndTripDetails> createState() => _EndTripDetailsState();
}

class _EndTripDetailsState extends State<EndTripDetails> {
  final _reviewform = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  Future<String> getUserName(String id) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    return data.get('UserName');
  }

  Future<String> getTrail() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .get();
    return data.get('Trail');
  }

  Widget getExpenses(String? ID) {
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
            return Center(
              child: Container(),
            );
          }
          double totalExpenses = 0;
          for (var element in snapshots.data!.docs) {
            var data = element.data() as Map<String, dynamic>;
            double expenses = double.parse(data['Amount'].toString());
            totalExpenses = totalExpenses + expenses;
          }
          return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ID != null
                    ? FutureBuilder<String>(
                        future: getUserName(ID!),
                        builder: (context, data) {
                          if (data.connectionState == ConnectionState.waiting) {
                            return Container();
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
              ]);
        });
  }

  ValueNotifier<int> _ratingNotifier = ValueNotifier<int>(0);

  endTrip(String id) {
    if (_reviewform.currentState!.validate()) {
      _reviewform.currentState!.save();
    FirebaseFirestore.instance
        .collection('Trails')
        .doc(id)
        .collection('Reviews')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'Review' : _reviewController.text.toString(),
      'Rating' : _ratingNotifier.value.toString()

    }).then((value){
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'Status': 'NotBusy'}).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IsBusy()),
        );
      });
    });
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppText(
            text: 'Details',
            fontSize: 20,
            color: AppColor.primaryDarkColor,
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Container(
                        width: 350,
                        decoration: BoxDecoration(
                            color: AppColor.primaryLightColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  spreadRadius: 3.5,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                foregroundImage:
                                    AssetImage('assets/icons/completesvg.png'),
                                radius: 70,
                              ),
                              const AppText(
                                text: 'Congratulations!',
                                fontSize: 30,
                              ),
                              const AppText(
                                text: 'You have completed your trail!',
                                fontSize: 15,
                              ),
                              const AppText(
                                text: 'Here are all the details.',
                                fontSize: 15,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(2, 2),
                                              spreadRadius: 3.5,
                                              blurRadius: 5,
                                              color: Colors.grey)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              AppText(
                                                text: 'Total Duration: ',
                                                fontSize: 15,
                                              ),
                                              AppText(
                                                text: '7 Days',
                                                fontSize: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: FutureBuilder<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>(
                                              future: FirebaseFirestore.instance
                                                  .collection('Groups')
                                                  .doc(widget.id)
                                                  .get(),
                                              builder: (_, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Container();
                                                }
                                                var data =
                                                    snapshot.data!.data();
                                                List members = data!['Members'];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: SizedBox(
                                                    height: 200,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ListView.builder(
                                                        // physics: const NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            members.length + 1,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          if (index == 0) {
                                                            return getExpenses(
                                                                null);
                                                          } else {
                                                            return getExpenses(
                                                                members[
                                                                    index - 1]);
                                                          }
                                                        }),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            width: 300,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      offset: Offset(2, 2),
                                                      spreadRadius: 3.5,
                                                      blurRadius: 5,
                                                      color: Colors.grey)
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                key: _reviewform,
                                                child: Column(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          AppText(
                                                            text:
                                                                'Leave a Review: ',
                                                            fontSize: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          children: [
                                                            TextFormField(
                                                              controller:
                                                                  _reviewController,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'This field cant be empty';
                                                                }
                                                                return null;
                                                              },
                                                            )
                                                          ],
                                                        )),
                                                    ValueListenableBuilder<int>(
                                                      valueListenable:
                                                          _ratingNotifier,
                                                      builder: (context, value,
                                                          child) {
                                                        return SizedBox(
                                                          width: 190,
                                                          height: 50,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: 5,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Container(
                                                                width: 35,
                                                                height: 35,
                                                                child:
                                                                    IconButton(
                                                                  icon: index <
                                                                          value
                                                                      ? const Icon(
                                                                          Icons
                                                                              .star,
                                                                          size:
                                                                              22,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              242,
                                                                              224,
                                                                              67))
                                                                      : const Icon(
                                                                          Icons
                                                                              .star_border,
                                                                          size:
                                                                              22),
                                                                  onPressed:
                                                                      () {
                                                                    _ratingNotifier
                                                                            .value =
                                                                        index +
                                                                            1;
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        FutureBuilder<String>(
                                            future: getTrail(),
                                            builder: (context, data) {
                                              if (data.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container();
                                              }
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, bottom: 20),
                                                child: AppButtons(
                                                    onPressed: () {
                                                      endTrip(data.data!);
                                                    },
                                                    child: const AppText(
                                                      text:
                                                          'Save and go to dashboard',
                                                    )),
                                              );
                                            })
                                      ]),
                                    ),
                                  ))
                            ]))))));
  }
}

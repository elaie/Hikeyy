import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../login_signup/is_in_trip.dart';

class EndTripDetails extends StatefulWidget {
  const EndTripDetails({super.key});

  @override
  State<EndTripDetails> createState() => _EndTripDetailsState();
}

class _EndTripDetailsState extends State<EndTripDetails> {
  ValueNotifier<int> _ratingNotifier = ValueNotifier<int>(0);
  endTrip() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Status': 'NotBusy'}).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IsBusy()),
      );
    });
  }

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
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
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          text: 'Total Expenses: ',
                                          fontSize: 15,
                                        ),
                                        AppText(
                                          text: 'Rs. 20000',
                                          fontSize: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          text: 'Total Expenses: ',
                                          fontSize: 15,
                                        ),
                                        AppText(
                                          text: 'Rs. 20000',
                                          fontSize: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          text: 'Leave a Review: ',
                                          fontSize: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [TextFormField()],
                                      )),
                                  ValueListenableBuilder<int>(
                                    valueListenable: _ratingNotifier,
                                    builder: (context, value, child) {
                                      return SizedBox(
                                        width: 190,
                                        height: 50,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: 35,
                                              height: 35,
                                              child: IconButton(
                                                icon: index < value
                                                    ? const Icon(Icons.star,
                                                        size: 22,
                                                        color: Color.fromARGB(
                                                            255, 242, 224, 67))
                                                    : const Icon(
                                                        Icons.star_border,
                                                        size: 22),
                                                onPressed: () {
                                                  _ratingNotifier.value =
                                                      index + 1;
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
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                child: AppButtons(
                    onPressed: () {
                      endTrip();
                    },
                    child: AppText(
                      text: 'Save and go to dashboard',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

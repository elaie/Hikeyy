import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/trails.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';
import 'package:hikeyy/widgets/location_month_icon_row.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({super.key});

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ], shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: AppTextHeading(
                          textHeading: 'Group Name',
                          fontSize: 25,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image(image: AssetImage('assets/images/group.png')),
                ),
                Container(
                  width: 800,
                  decoration: BoxDecoration(
                      color: AppColor.primaryLightColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //show all members here
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(200),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/orange_background.png'))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(200),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/green_background.png'))),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 100.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 128, 206, 131),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text("You've Joined"),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: 800,
                          width: 800,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    spreadRadius: 2)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const LocationMonthIconRow(
                                          location: 'EBC', date: 'Jan'),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100.0),
                                        child: AppButtons(
                                            //navigate to venu details page
                                            onPressed: () {},
                                            child: const AppText(
                                                text: 'View Trail')),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(right: 15.0, top: 10),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 30),
                                    child: AppTextSubHeading(
                                        text:
                                            'Very nice place bla bla add discription about place'),
                                  ),
                                ]),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.white, blurRadius: 8, spreadRadius: 10),
        ], color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
          child: SizedBox(
            height: 50,
            // decoration: BoxDecoration(color: Colors.amber),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtons(
                    onPressed: () {},
                    child: const AppText(text: 'Start Trail!')),
                AppButtons(
                    onPressed: () {},
                    child: AppText(
                      text: 'Nearby Devices',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

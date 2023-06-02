import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/my_schedule_card.dart';
import 'package:hikeyy/screens/home_page/widget/venu_card.dart';
import 'package:hikeyy/screens/login_signup/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/green_background.png'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 250.0),
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 25.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 17),
                        ),
                        Text('See all')
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        VenuCard(
                          venue: 'Mt. Everest',
                          location: 'Nepal',
                          date: 'July',
                        ),
                        VenuCard(
                          venue: 'ABC Babyy',
                          location: 'Nepal',
                          date: 'July',
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Schedule',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 17),
                        ),
                        Text('See all')
                      ],
                    ),
                  ),
                  MyScheduleCard(),
                  MyScheduleCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

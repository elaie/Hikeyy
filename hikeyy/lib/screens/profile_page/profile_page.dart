import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/my_schedule_card.dart';

import '../login_signup/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/green_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 20,
              ),
              //for white container
              Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                ),
              ),
              //username
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  'User Name Here',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //profile picture
              Positioned(
                top: 60,
                child: GestureDetector(
                    onTap: () {
                      print('image pressed');
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        //for circle outline on pp
                        border: Border.all(
                          width: 3,
                          color: Colors.green,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    )),
              ),
              //bio
              Positioned(
                top: 270,
                child: const Column(
                  children: [
                    Text(
                      'display bio here',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //edit button
              Positioned(
                top: 300,
                child: ElevatedButton(
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                        fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      (Colors.green),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 90), child: MyScheduleCard()),

              Positioned(top: 500, child: Text('*show other schedules here*')),

              //logout button
              Positioned(
                top: 630,
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        (Colors.green),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: Text('LogOut'),
                  ),
                ),
              ),
              //Highlights
            ],
          ),
        ),
      ),
    );
  }
}

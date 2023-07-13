import 'package:flutter/material.dart';
import 'package:hikeyy/screens/dashboard/dashboard.dart';
import 'package:hikeyy/screens/login_signup/is_in_trip.dart';

import '../../../widgets/app_texts.dart';
import '../../about_us/about_us.dart';
import '../../helpline_page/helpline_page.dart';
import '../../safety_guidelines/safety_guidelines.dart';

class DrawerApp extends StatelessWidget {
  final String userName;
  final String PfUrl;
  const DrawerApp({Key? key, required this.userName, required this.PfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child:  const Image(
                    image: AssetImage('assets/images/logo.png')),
              ),
            ),
            AppText(
              text: 'Hi! $userName',
              fontSize: 20,
              maxLines: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 50.0, left: 20, right: 20, bottom: 50),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                      child: PfUrl == ' '
                          ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(200),
                            image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/profile.png'))),
                      )
                          : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(200),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(PfUrl),
                            )),
                      )
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const IsBusy(index: 2,)),
                  );
                },
                child: const AppText(
                  text: 'Profile',
                  fontSize: 15,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SafetyGuidelines()));
                },
                child: AppText(
                  text: 'Safety Guidelines',
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpLinePage()));
                },
                child: AppText(
                  text: 'Helpline numbers',
                  fontSize: 15,
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUs()));
                },
                child: AppText(
                  text: 'About us',
                  fontSize: 15,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: AppText(
                    text: 'Logout',
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 100),
                  child: Icon(Icons.logout),
                )
              ],
            )
          ],
        ));
  }
}

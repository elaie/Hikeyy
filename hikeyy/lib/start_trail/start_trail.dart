import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikeyy/start_trail/Expenses.dart';
import 'package:hikeyy/start_trail/friendslocation.dart';
import 'package:hikeyy/start_trail/widgets/collapseable_options.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../widgets/app_buttons.dart';

class StartTrail extends StatefulWidget {
  final String id;
  const StartTrail({super.key, required this.id});

  @override
  State<StartTrail> createState() => _StartTrailState();
}

class _StartTrailState extends State<StartTrail> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit this App'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop().then((value) {
              false;
            }),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
  FirebaseAuth auth= FirebaseAuth.instance;
  Timer? timer;
  getTokenId() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'TokenId': fcmToken}).then((value) {
      //print(fcmToken);
     // print('@@@@@@@@@@@@@@@@@@@@@');
    });
  }
  // ignore: non_constant_identifier_names
  Future<void> UpdateLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
   // print(permission);
  Geolocator.getCurrentPosition().then((value){
  FirebaseFirestore.instance.collection('Groups').doc(widget.id).collection('Locations').doc(auth.currentUser?.uid).set({
    'Position': GeoPoint(value.latitude,value.longitude),
    'Time' : DateTime.now()
  });
  });
  //print('33333333333333333333333333333');
  }
  @override
  void initState() {
    // TODO: implement initState
    //LocationPermission permission = await Geolocator.checkPermission();
    //print(permission);
    getTokenId();
    UpdateLocation();
    super.initState();

    timer = Timer.periodic(Duration(seconds: 30), (timer) {
      UpdateLocation();
    });

  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(left: 5.0),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                _onWillPop();
                              },
                            ))),
                    const Padding(
                      padding: EdgeInsets.only(right: 50.0),
                      child: AppText(
                        text: '*enter group name*',
                        fontSize: 20,
                        color: AppColor.primaryColor,
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 200, maxWidth: 295),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Stack(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: const Image(
                            image: AssetImage('assets/images/EBC.jpg'),
                            fit: BoxFit.cover,
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.grey,
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 100,
                        left: 20,
                        child: AppText(
                          text: 'Destination Name',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Positioned(
                          top: 100,
                          left: 250,
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 130, left: 15, right: 15),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 150,
                        left: 20,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: const AppText(
                            text:
                                'The Everest Base Camp trek on the south side, at an elevation of 5,364 m (17,598 ft), is one of the most popular trekking routes in the Himalayas and about 40,000 people per year make the trek there from Lukla Airport (2,846 m (9,337 ft)). Trekkers usually fly from Kathmandu to Lukla to save time and energy before beginning the trek to the base camp.',
                            color: Color.fromARGB(255, 223, 223, 223),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
                //group members

                //checkpoints
                CollapsibleOptions(id: widget.id,),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: AppButtons(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationFriends(id: widget.id)));
                      },
                      child: const AppText(
                        text: 'Nearby Devices',
                      )),
                ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: AppButtons(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Expenses(id: widget.id)));
                          },
                          child: const AppText(
                            text: 'Expenses',
                          )),
                    ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

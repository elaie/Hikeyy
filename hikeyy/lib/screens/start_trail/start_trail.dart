import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hikeyy/screens/expenses/expense.dart';
import 'package:hikeyy/screens/group_details/friendslocation.dart';
import 'package:hikeyy/screens/group_details/widgets/collapseable_options.dart';
import 'package:hikeyy/screens/home_page/widget/Drawer.dart';
import 'package:hikeyy/screens/start_trail/widgets/timeline_collapsable.dart';

import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';
import 'package:http/http.dart' as http;

import '../../widgets/app_buttons.dart';
import '../end_trip_details/end_trip_details.dart';
class StartTrail extends StatefulWidget {
  final String id;

  const StartTrail({super.key, required this.id});

  @override
  State<StartTrail> createState() => _StartTrailState();
}

class _StartTrailState extends State<StartTrail> {
  List<String> positions = [];
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit this App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop().then((value) {
                  false;
                }),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
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

 

  getDistance() async {
    List<LatLng>? points;
    GeoPoint? mypos;
    int? posdetail;
    String? status;
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .collection('Locations')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshots) async {
      mypos = snapshots.data()!['Position'];
      posdetail = snapshots.data()?['pos'];
      status = snapshots.data()?['Status'];
    });
    //TrailID
    // DocumentSnapshot group= await FirebaseFirestore.instance.collection('Group').doc(widget.id).get();
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      Map<String, dynamic>? data = snapshot.data();
      QuerySnapshot datas = await FirebaseFirestore.instance
          .collection('Trails')
          .doc(data!['Trail'])
          .collection('Cordinates')
          .get();
      points = List.generate(datas.docs.length,
          (index) => LatLng(index.toDouble(), index.toDouble()));
      for (var element in datas.docs) {
        String lat = element['Latitude'];
        String lon = element['Longitude'];
        int pos = element['pos'];
        points![pos] = LatLng(double.parse(lat), double.parse(lon));
      }
    });
    if (posdetail == null && status == 'Going') {
      for (int i = 0; i <= points!.length - 1; i++) {
        var distance = Geolocator.distanceBetween(points![i].latitude,
            points![i].longitude, mypos!.latitude, mypos!.longitude);
        if (distance <= 200) {
          await FirebaseFirestore.instance
              .collection('Groups')
              .doc(widget.id)
              .collection('Locations')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'pos': i}).then((value) async {
            await FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Timeline')
                .add({
              'User': FirebaseAuth.instance.currentUser!.uid,
              'Time': DateTime.now(),
              'pos': i
            });
          });
          //add the pos to the db
          break;
        }
        // print(points);
        //   print('####################');
      }
    } else if (posdetail! != points!.length - 1 && status == 'Going') {
      for (int i = posdetail! + 1; i <= points!.length - 1; i++) {
        var distance = Geolocator.distanceBetween(points![i].latitude,
            points![i].longitude, mypos!.latitude, mypos!.longitude);
        if (distance <= 200) {
          await FirebaseFirestore.instance
              .collection('Groups')
              .doc(widget.id)
              .collection('Locations')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'pos': i}).then((value) async {
            await FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Timeline')
                .add({
              'User': FirebaseAuth.instance.currentUser!.uid,
              'Time': DateTime.now(),
              'pos': i
            });
          });
          //add the pos to the db
          break;
        }
      }
    } else if (posdetail! == points!.length - 1 && status == 'Going') {
      await FirebaseFirestore.instance
          .collection('Group')
          .doc(widget.id)
          .collection('Locations')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'Status': 'Returning'});
    } else if (status == 'Returning' && posdetail! != 0) {
      for (int i = posdetail! - 1; i >= 0; i--) {
        var distance = Geolocator.distanceBetween(points![i].latitude,
            points![i].longitude, mypos!.latitude, mypos!.longitude);
        if (distance <= 200) {
          await FirebaseFirestore.instance
              .collection('Groups')
              .doc(widget.id)
              .collection('Locations')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'pos': i}).then((value) async {
            await FirebaseFirestore.instance
                .collection('Groups')
                .doc(widget.id)
                .collection('Timeline')
                .add({
              'User': FirebaseAuth.instance.currentUser!.uid,
              'Time': DateTime.now(),
              'pos': i
            });
          });
          //add the pos to the db
          break;
        }
      }
    } else if (status == 'Returning' && posdetail! == 0) {
      await FirebaseFirestore.instance
          .collection('Group')
          .doc(widget.id)
          .collection('Locations')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'Status': 'Ended'});
    }
  }

  getLocations() async {
    //List<String> points=[];
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      Map<String, dynamic>? data = snapshot.data();
      QuerySnapshot datas = await FirebaseFirestore.instance
          .collection('Trails')
          .doc(data!['Trail'])
          .collection('Cordinates')
          .get();
      positions = List.generate(datas.docs.length, (index) => index.toString());
      for (var element in datas.docs) {
        int pos = element['pos'];
        String name = element['Name'];
        positions[pos] = name;
      }
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> UpdateLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      // print("ERROR" + error.toString());
    });
    // print(permission);
    Geolocator.getCurrentPosition().then((value) {
      FirebaseFirestore.instance
          .collection('Groups')
          .doc(widget.id)
          .collection('Locations')
          .doc(auth.currentUser?.uid)
          .update({
        'latitude': value.latitude,
        'longitude': value.longitude,
        'Position': GeoPoint(value.latitude, value.longitude),
        'Time': DateTime.now()
      });
    });
    //print('33333333333333333333333333333');
  }

  emergencycall() async {
    DocumentSnapshot dataG = await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .get();

    List members = dataG['Members'];
    DocumentSnapshot dataMe = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var element in members) {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection('Users')
          .doc(element)
          .get();
      try {
        http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization':
                  'key=AAAAmBUmFv8:APA91bHyUqeVPNp2YUQx4J3S4nJMupqms0CprTzq1RD-aQqJaJcZwb7QhvK-GWuj-qPzc1vKXVvJKFyUT4bFYlRGxLREnbD-amKaWWeVuaxUvMsOdYNK4aEcJnUjIWRJRQm-bbv-3kTA'
            },
            body: jsonEncode(<String, dynamic>{
              'priority': 'high',
              'data': <String, dynamic>{
                'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                'status': 'done',
                'body':
                    '${dataMe['UserName']} call for emergency. Please look map for his location or Call them',
                'title': 'Emergency!!!!!'
              },
              "notification": <String, dynamic>{
                "title": "Emergency!!!!",
                "body":
                    "${dataMe['UserName']} call for emergency. Please look map for his location or Call them",
                "android_channel_id": 'db'
              },
              "to": data['TokenId']
            }));
      } catch (e) {
        //print(e);
      }
    }
  }

  String userName = '';
  String PfUrl = '';

  Future<void> getUserName() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .get();
    setState(() {
      userName = data['UserName'];
      PfUrl = data['pfpUrl'];
    });
  }

  @override
  void initState() {
    //LocationPermission permission = await Geolocator.checkPermission();
    //print(permission);
    getTokenId();
    UpdateLocation();
    getDistance();
    getUserName();
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      UpdateLocation();
      getDistance();
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
          key: _scaffoldkey,
          drawer: DrawerApp(
            userName: userName,
            PfUrl: PfUrl,
          ),
          body: FutureBuilder<void>(
              future: getLocations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SafeArea(
                  child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                        if (snapshot.connectionState == ConnectionState.done) {
                          var data = snapshot.data!.data();
                          List<dynamic> members = data!['Members'];
                          var name = data['Name'];
                          // print(data['Trail']);
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _scaffoldkey
                                              .currentState!
                                              .openDrawer(),
                                          child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 9,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ], shape: BoxShape.circle, color: Colors.white),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Image(
                                                    image:
                                                    AssetImage('assets/icons/menu.png')),
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 40.0),
                                          child: AppText(
                                            text: name.toString(),
                                            fontSize: 20,
                                            color: AppColor.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: members.length,
                                                itemBuilder: (context, index) {
                                                  return FutureBuilder<
                                                          DocumentSnapshot<
                                                              Map<String,
                                                                  dynamic>>>(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection('Users')
                                                          .doc(members[index])
                                                          .get(),
                                                      builder: (_, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        10.0),
                                                            child: Container(
                                                              height: 40,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              200),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(snapshot
                                                                          .data!
                                                                          .data()!['pfpUrl']))),
                                                            ),
                                                          );
                                                        }
                                                        return Container();
                                                      });
                                                }),
                                            AppButtons(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LocationFriends(
                                                                  id: widget
                                                                      .id)));
                                                },
                                                child: const AppText(
                                                  text: 'Friends Nearby',
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      child: FutureBuilder<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>(
                                          future: FirebaseFirestore.instance
                                              .collection('Trails')
                                              .doc(data['Trail'])
                                              .get(),
                                          builder: (_, snapshots) {
                                            if (snapshots.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshots.connectionState ==
                                                ConnectionState.done) {
                                              var dataT =
                                                  snapshots.data!.data();
                                              List<dynamic> photourls =
                                                  dataT!['PhotoURLs'];
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 30.0),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 300,
                                                          maxWidth: 350),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Stack(children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Image(
                                                          height: 400,
                                                          image: NetworkImage(
                                                              photourls.first),
                                                          fit: BoxFit.fitHeight,
                                                        )),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.transparent,
                                                            Colors.grey,
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 100, left: 20),
                                                      child: AppText(
                                                        text: dataT['Name'],
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 130,
                                                          left: 15,
                                                          right: 15),
                                                      child: Divider(
                                                        thickness: 1,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 150, left: 20),
                                                      child: Container(
                                                        width: 300,
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth: 400),
                                                        child: AppText(
                                                          text: dataT[
                                                              'Description'],
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              223, 223, 223),
                                                          maxLines: 6,
                                                          textOverflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              );
                                            }
                                            return Container();
                                          }),
                                    ),

                                    //timeline
                                    TimelineCollapsable(
                                      id: widget.id,
                                      checkpoints: positions,
                                    ),
                                    //checkpoints
                                    CollapsibleOptions(
                                      id: widget.id,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25.0, bottom: 25),
                                          child: AppButtons(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Expenses(
                                                                id: widget
                                                                    .id)));
                                              },
                                              child: const AppText(
                                                text: 'Expenses',
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25.0, bottom: 25),
                                          child: Builder(builder: (context) {
                                            return AppButtons(
                                                color: const Color.fromARGB(
                                                    255, 183, 49, 39),
                                                onPressed: () {
                                                  emergencycall();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: AppText(
                                                    text:
                                                        'Emergency signal sent!',
                                                  )));
                                                },
                                                child: const AppText(
                                                  text: 'Emergency',
                                                ));
                                          }),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 25.0),
                                        child: Builder(builder: (context) {
                                          return AppButtons(
                                              color: const Color.fromARGB(
                                                  255, 183, 49, 39),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EndTripDetails(id: widget.id,)));
                                                //endTrip();

                                              },
                                              child: const AppText(
                                                text: 'End Trip',
                                              ));
                                        }),
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        }
                        return Container();
                      }),
                );
              })),
    );
  }
}

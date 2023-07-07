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
import 'package:hikeyy/start_trail/TimeLine.dart';
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
  List<String> positions = [];

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
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.id)
        .collection('Locations')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshots) async {
      mypos = snapshots.data()!['Position'];
      posdetail = snapshots.data()?['pos'];
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
    if (posdetail == null) {
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
    } else {
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
        positions![pos] = name;
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
        'Position': GeoPoint(value.latitude, value.longitude),
        'Time': DateTime.now()
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
    getDistance();
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
                                        Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: IconButton(
                                                  icon: const Icon(
                                                      Icons.arrow_back_ios),
                                                  onPressed: () {
                                                    _onWillPop();
                                                  },
                                                ))),
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
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
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
                                                        ConnectionState.done) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10.0),
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
                                                                          .data()![
                                                                      'pfpUrl']))),
                                                        ),
                                                      );
                                                    }
                                                    return Container();
                                                  });
                                            }),
                                      ),
                                    ),
                                    FutureBuilder<
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
                                            var dataT = snapshots.data!.data();
                                            List<dynamic> photourls =
                                                dataT!['PhotoURLs'];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30.0),
                                              child: Container(
                                                constraints:
                                                    const BoxConstraints(
                                                        maxHeight: 300,
                                                        maxWidth: 500),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Stack(children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Image(
                                                        image: NetworkImage(
                                                            photourls.first),
                                                        fit: BoxFit.cover,
                                                      )),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.grey,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 100,
                                                    left: 20,
                                                    child: AppText(
                                                      text: dataT['Name'],
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const Positioned(
                                                      top: 100,
                                                      left: 400,
                                                      child: Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      )),
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
                                                  Positioned(
                                                    top: 150,
                                                    left: 20,
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              maxWidth: 400),
                                                      child: AppText(
                                                        text: dataT[
                                                            'Description'],
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 223, 223, 223),
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

                                    // group members
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: AppButtons(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => TimeLine(id: widget.id, checkpoints: positions)));
                                          },
                                          child: const AppText(
                                            text: 'TimeLine',
                                          )),
                                    ),
                                    //checkpoints
                                    CollapsibleOptions(
                                      id: widget.id,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: AppButtons(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LocationFriends(
                                                            id: widget.id)));
                                          },
                                          child: const AppText(
                                            text: 'Nearby Devices',
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: AppButtons(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Expenses(
                                                            id: widget.id)));
                                          },
                                          child: const AppText(
                                            text: 'Expenses',
                                          )),
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

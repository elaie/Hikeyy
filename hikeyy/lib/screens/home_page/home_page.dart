// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/Drawer.dart';
import 'package:hikeyy/screens/home_page/widget/venu_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikeyy/screens/profile_page/my_friend_request.dart';
import 'package:hikeyy/screens/venue_details/venue_details_page.dart';

import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/location_month_icon_row.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../widgets/app_buttons.dart';
import '../../widgets/app_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  final ImagePicker picker = ImagePicker();

  // Pick multiple images
  final List<XFile> pickedFiles = await picker.pickMultiImage(imageQuality: 80);

  for (var i = 0; i < pickedFiles.length; i++) {
    File image = File(pickedFiles[i].path);
    images.add(image);
  }

  return images;
}

void uploadImages(List<File> images) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];

  for (var i = 0; i < images.length; i++) {
    File image = images[i];

    // Create a unique filename for each image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the location you want to upload to in Firebase Storage
    Reference ref = storage.ref().child('images/$fileName');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = ref.putFile(image);

    // Get the download URL once the upload is complete
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    imageUrls.add(imageUrl);
  }
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String userName = '';
  String PfUrl='';
  bool showfilter = false;
  RangeValues _currentRangeValues = const RangeValues(0, 100000);
  RangeValues _currentTimeRangeValues = const RangeValues(0, 30);

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
    getUserName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        drawer: DrawerApp(userName: userName,PfUrl: PfUrl,),
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/green_background.png'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
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
                            onTap: () =>
                                _scaffoldkey.currentState!.openDrawer()),
                        const AppText(
                          text: "Welcome,\nLet's Plan Your Trip!",
                          fontSize: 20,
                          alignment: TextAlign.center,
                        ),
                        GestureDetector(
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
                              child: const Icon(Icons.notifications)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyFriendRequest()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 23),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: 'Explore',
                                          fontSize: 25,
                                        ),
                                        AppText(
                                          text: 'New Places',
                                          fontSize: 25,
                                          color: AppColor.primaryDarkColor,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showfilter = true;
                                          });
                                        },
                                        child: const Text('Filters'))
                                  ],
                                ),
                              ),
                              if (showfilter)
                                SizedBox(
                                  height: 200,
                                  width: double.infinity,
                                  //color: Colors.green,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Budget',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 17),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: RangeSlider(
                                            activeColor: Colors.green,
                                            values: _currentRangeValues,
                                            max: 100000,
                                            divisions: 100,
                                            labels: RangeLabels(
                                              _currentRangeValues.start
                                                  .round()
                                                  .toString(),
                                              _currentRangeValues.end
                                                  .round()
                                                  .toString(),
                                            ),
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                _currentRangeValues = values;
                                              });
                                            },
                                          ),
                                        ),
                                        const Text(
                                          'Time',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 17),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: RangeSlider(
                                            activeColor: Colors.green,
                                            values: _currentTimeRangeValues,
                                            max: 30,
                                            divisions: 30,
                                            labels: RangeLabels(
                                              _currentTimeRangeValues.start
                                                  .round()
                                                  .toString(),
                                              _currentTimeRangeValues.end
                                                  .round()
                                                  .toString(),
                                            ),
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                _currentTimeRangeValues =
                                                    values;
                                              });
                                            },
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AppButtons(
                                                onPressed: () {
                                                  setState(() {
                                                    showfilter = false;
                                                  });
                                                },
                                                child: const AppText(
                                                  text: 'Apply',
                                                )),
                                            AppButtons(
                                                onPressed: () {
                                                  setState(() {
                                                    _currentRangeValues =
                                                        const RangeValues(
                                                            0, 100000);
                                                    _currentTimeRangeValues =
                                                        const RangeValues(
                                                            0, 30);
                                                    showfilter = false;
                                                  });
                                                },
                                                child: const AppText(
                                                  text: 'Reset',
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Container(),
                              !showfilter
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 45.0, top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          (_currentRangeValues !=
                                                  const RangeValues(0, 100000))
                                              ? Container(
                                                  width: 190,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  128,
                                                                  206,
                                                                  131),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                  child: Center(
                                                      child: Column(
                                                    children: [
                                                      const Text('Budget'),
                                                      Text('Rs.' +
                                                          _currentRangeValues
                                                              .start
                                                              .toString() +
                                                          "- Rs." +
                                                          _currentRangeValues
                                                              .end
                                                              .toString()),
                                                    ],
                                                  )),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          (_currentTimeRangeValues !=
                                                  const RangeValues(0, 30))
                                              ? Container(
                                                  width: 190,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              Color.fromARGB(
                                                                  255,
                                                                  128,
                                                                  206,
                                                                  131),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                  child: Center(
                                                      child: Column(
                                                    children: [
                                                      const Text('Time'),
                                                      Text(_currentTimeRangeValues
                                                              .start
                                                              .toString() +
                                                          "-" +
                                                          _currentTimeRangeValues
                                                              .end
                                                              .toString() +
                                                          'Days'),
                                                    ],
                                                  )),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Trails')
                                    .where('Budget',
                                        isGreaterThanOrEqualTo:
                                            _currentRangeValues.start,
                                        isLessThanOrEqualTo:
                                            _currentRangeValues.end)
                                    .snapshots(),
                                builder: (context, snapshots) {
                                  if (snapshots.hasError) {
                                    return Text('Error: ${snapshots.error}');
                                  }
                                  if (!snapshots.hasData) {
                                    return const Text('No data available');
                                  }
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(

                                          child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 1,
                                                childAspectRatio: 1.1,
                                              ),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              padding: const EdgeInsets.all(10),
                                              itemCount:
                                                  snapshots.data!.docs.length,
                                              itemBuilder: (context, index) {

                                                var data = snapshots
                                                    .data!.docs[index]
                                                    .data()
                                                as Map<String, dynamic>;
                                                String id = snapshots
                                                    .data!.docs[index].id;
                                                List<dynamic> photos =
                                                data["PhotoURLs"];
                                                return data['Duration'] >=
                                                    _currentTimeRangeValues
                                                        .start &&
                                                    data['Duration'] <=
                                                        _currentTimeRangeValues
                                                            .end?
                                                InkWell(
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                              VenueDetailsPage(
                                                                id: id,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                      child: Container(
                                                        height: 300,
                                                        width: 130,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(15),
                                                            image: DecorationImage(
                                                                image: NetworkImage(photos.first),
                                                                fit: BoxFit.cover),
                                                            color: Colors.amber),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(15),
                                                            gradient: LinearGradient(
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              colors: [
                                                                Colors.transparent,
                                                                Colors.black
                                                                    .withOpacity(0.8),
                                                              ],
                                                            )),

                                                          //   onTap: () {
                                                          //     Navigator.push(
                                                          //       context,
                                                          //       MaterialPageRoute(
                                                          //         builder:
                                                          //             (context) =>
                                                          //                 VenueDetailsPage(
                                                          //           id: id,
                                                          //         ),
                                                          // ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.center,
                                                            children: [
                                                               AppText(
                                                                text:  data['Name'].toString(),
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 10.0, right: 10),
                                                                child: Divider(
                                                                  thickness: 1,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(
                                                                    left: 8.0),
                                                                child: AppTextSubHeading(
                                                                  maxLines: 2,
                                                                  textOverflow:
                                                                  TextOverflow.ellipsis,
                                                                  text: data['Description'].toString(),
                                                                ),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: 10.0, right: 10),
                                                                child: Divider(
                                                                  thickness: 1,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: LocationMonthIconRow(location:data['Location'].toString(),date:data['Duration'].toString() ,)
                                                              ),
                                                              const SizedBox(height: 20,)
                                                              // Padding(
                                                              //   padding:
                                                              //   const EdgeInsets.only(
                                                              //       bottom: 20.0,
                                                              //       right: 15),
                                                              //   child: AnimatedPositioned(
                                                              //     duration: const Duration(
                                                              //         milliseconds: 300),
                                                              //     child: Row(
                                                              //         mainAxisAlignment:
                                                              //         MainAxisAlignment
                                                              //             .spaceEvenly,
                                                              //         children:
                                                              //         List.generate(
                                                              //           5,
                                                              //               (index) => SizedBox(
                                                              //             height: 15,
                                                              //             width: 20,
                                                              //             child: IconButton(
                                                              //               icon: index <
                                                              //                   _rating
                                                              //                   ? const Icon(
                                                              //                   Icons
                                                              //                       .star,
                                                              //                   size:
                                                              //                   22)
                                                              //                   : const Icon(
                                                              //                   Icons
                                                              //                       .star_border,
                                                              //                   size:
                                                              //                   22),
                                                              //               color: const Color
                                                              //                   .fromARGB(
                                                              //                   255,
                                                              //                   223,
                                                              //                   170,
                                                              //                   10),
                                                              //               onPressed:
                                                              //                   () {},
                                                              //             ),
                                                              //           ),
                                                              //         )),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  //onTap: () {},
                                                  ):Container();
                                              })),
                                          // ListView.builder(
                                          //     physics:
                                          //         const ClampingScrollPhysics(),
                                          //     shrinkWrap: true,
                                          //     //scrollDirection: Axis.horizontal,
                                          //     padding: const EdgeInsets.all(10),
                                          //     itemCount:
                                          //         snapshots.data!.docs.length,
                                          //     itemBuilder: (context, index) {
                                          //       var data = snapshots
                                          //               .data!.docs[index]
                                          //               .data()
                                          //           as Map<String, dynamic>;
                                          //       String id = snapshots
                                          //           .data!.docs[index].id;
                                          //       List<dynamic> photos =
                                          //           data["PhotoURLs"];
                                          //       return data['Duration'] >=
                                          //                   _currentTimeRangeValues
                                          //                       .start &&
                                          //               data['Duration'] <=
                                          //                   _currentTimeRangeValues
                                          //                       .end
                                          //           ? Row(
                                          //               children: [
                                          //                 GestureDetector(
                                          //                   child: VenuCard(
                                          //                     photourl:
                                          //                         photos.first,
                                          //                     venue:
                                          //                     data['Name'].toString(),
                                          //                     location: 'Nepal',
                                          //                     date: 'july',
                                          //                   ),
                                          //                   onTap: () {
                                          //                   },
                                          //                 ),
                                          //               ],
                                          //             )
                                          //           : Container();
                                          //     }),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Container()
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/plan_trip_page/plan_trip_page.dart';
import 'package:hikeyy/screens/venue_details/Checkpoint.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../../widgets/app_buttons.dart';
import '../group_details/widgets/collapseable_options.dart';
import '../home_page/widget/trails.dart';

class VenueDetailsPage extends StatefulWidget {
  final String id;

  const VenueDetailsPage({super.key, required this.id});

  @override
  State<VenueDetailsPage> createState() => _VenueDetailsPageState();
}

class _VenueDetailsPageState extends State<VenueDetailsPage> {

  var _rating = 0;
  ValueNotifier<int> _ratingNotifier = ValueNotifier<int>(0);



  int selectedRating = 3; // Replace with rating value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Trails')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data();
                List<dynamic> photos = data!['PhotoURLs'];
                List<dynamic> bestMonths = data['BestMonths'];
                // print(BestMonths);
                //  print('****************');\
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            photos.isEmpty
                                ? const CircularProgressIndicator()
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: showPhotos(photos),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 30),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: IconButton(
                                        icon: const Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ))),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: AppTextHeading(
                                            maxLines: 2,
                                            fontSize: 20,
                                            textHeading: data['Name'],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on),
                                            AppText(text: data['Location'])
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 1,
                                                offset: Offset(0, 3),
                                                blurRadius: 3),
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(30)),
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColor.primaryColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Trails(id: widget.id)),
                                          );
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(Icons.directions),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(left: 2.0),
                                              child: AppText(
                                                text: 'View in Map',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 5, right: 5),
                                  child: Container(
                                    constraints:
                                    const BoxConstraints(minHeight: 100),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 3,
                                              offset: Offset(0, 3))
                                        ],
                                        color: AppColor.primaryLightColor,
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(children: [
                                        Column(
                                          children: [
                                            AppText(text: 'Ratings'),
                                            Row(
                                              children: [
                                                AppText(
                                                    text: selectedRating
                                                        .toString()),
                                                Icon(Icons.star,
                                                    color: Colors.yellow)
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 70,
                                          child: VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 0,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            ValueListenableBuilder<int>(
                                              valueListenable: _ratingNotifier,
                                              builder: (context, value, child) {
                                                return SizedBox(
                                                  width: 190,
                                                  height: 50,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    itemCount: 5,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        width: 35,
                                                        height: 35,
                                                        child: IconButton(
                                                          icon: index < value
                                                              ? const Icon(
                                                              Icons.star,
                                                              size: 22,
                                                              color: Colors
                                                                  .yellow)
                                                              : const Icon(
                                                              Icons
                                                                  .star_border,
                                                              size: 22),
                                                          onPressed: () {
                                                            _ratingNotifier
                                                                .value =
                                                                index + 1;
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                            GestureDetector(
                                              child: const AppText(
                                                  text: 'Submitt'),
                                              onTap: () {},
                                            )
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                                Checkpoint(id: widget.id),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: AppTextHeading(
                                    textHeading: 'Description',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data['Description'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(top: 15.0, bottom: 15),
                                  child: AppTextHeading(
                                    textHeading: 'Best Months',
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: bestMonths.length,
                                      itemBuilder: (context, index) {
                                        // print(BestMonths[index]);
                                        //  print('***************************');
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Container(
                                            width: 100,
                                            constraints: const BoxConstraints(
                                                minHeight: 100),
                                            decoration: BoxDecoration(
                                                color:
                                                AppColor.primaryLightColor,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(bestMonths[index])),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Container(
                    decoration: const BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 20,
                          spreadRadius: 20,
                          offset: Offset(0, -5)),
                    ], color: Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 20),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const AppText(
                                  text: 'Estimated cost',
                                  fontSize: 17,
                                ),
                                AppTextSubHeading(
                                    text: '    Rs.${data['Budget']} per person')
                              ],
                            ),
                            AppButtons(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlanTripPage(id: widget.id)));
                              },
                              child: const Row(
                                children: [
                                  AppText(
                                      text: 'Plan Trip', color: Colors.white),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }
}

Widget showPhotos(List? data) {
  return data!.isEmpty
      ? const Text('No data')
      : SingleChildScrollView(
    child: CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (context, index, realIndex) {
          //final document = data![index];
          // print(data[index]);
          //p/rint('*******************');
          return Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 10),
                          blurRadius: 4)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    data[index],
                    fit: BoxFit.fitHeight,
                    height: 300,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                ),
              ));
        },
        options: CarouselOptions(
            height: 350,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            autoPlayCurve: Curves.fastOutSlowIn)),
  );
}

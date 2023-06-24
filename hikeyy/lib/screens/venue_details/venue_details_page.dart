import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/plan_trip_page/plan_trip_page.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../home_page/widget/trails.dart';

class VenueDetailsPage extends StatefulWidget {
  final String id;

  const VenueDetailsPage({super.key, required this.id});

  @override
  State<VenueDetailsPage> createState() => _VenueDetailsPageState();
}

class _VenueDetailsPageState extends State<VenueDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/green_background.png'),
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter),
        ),
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
                List<dynamic> Photos = data!['PhotoURLs'];
                List<dynamic> BestMonths = data['BestMonths'];
               // print(BestMonths);
              //  print('****************');
                return Column(
                  children: [
                    ShowPhotos(Photos),
                    Expanded(
                      child: Container(
                        //height: MediaQuery.of(context).size.height-,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
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
                                        AppTextHeading(
                                          fontSize: 20,
                                          textHeading: data!['Name'],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            AppText(text: data['Location'])
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
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
                                              padding: EdgeInsets.only(left: 2.0),
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
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minHeight: 100),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryLightColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(children: [
                                        const Column(
                                          children: [
                                            AppText(text: 'Ratings'),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 233, 217, 74),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 70,
                                          child: const VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 0,
                                          ),
                                        ),
                                        const Column(
                                          children: [
                                            AppText(text: 'Members'),
                                            AppText(text: 'Display Members here')
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: AppTextHeading(
                                    textHeading: 'Discription',
                                    fontSize: 20,
                                  ),
                                ),
                                AppTextSubHeading(text: data['Discription']),
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0,bottom: 15),
                                  child: AppTextHeading(
                                    textHeading: 'Best Months',
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                      itemCount: BestMonths.length,
                                      itemBuilder: (context, index) {
                                       // print(BestMonths[index]);
                                      //  print('***************************');
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            width: 50,
                                            constraints:
                                            const BoxConstraints(minHeight: 100),
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryLightColor,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Center(child: Text(BestMonths[index])),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          // decoration: BoxDecoration(color: Colors.amber),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const AppText(
                    text: 'Estimated cost',
                    fontSize: 17,
                  ),
                  AppTextSubHeading(text: 'Rs.1 per person')
                ],
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlanTripPage(id: widget.id)));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: AppText(
                          text: 'Plan Trip',
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ShowPhotos(List? data) {
  return SafeArea(
      child: data!.isEmpty
          ? const Text('No data')
          : SingleChildScrollView(
              child: CarouselSlider.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index, realIndex) {
                    //final document = data![index];
                    // print(data[index]);
                    //p/rint('*******************');
                    return Center(
                        child: Image.network(
                      data[index],
                      fit: BoxFit.fill,
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                    ));
                  },
                  options: CarouselOptions(
                      height: 300,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      autoPlayCurve: Curves.fastOutSlowIn)),
            ));
}

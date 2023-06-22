import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_texts.dart';
import 'package:hikeyy/widgets/location_month_icon_row.dart';

import '../home_page/widget/trails.dart';

class VenueDetailsPage extends StatefulWidget {
  const VenueDetailsPage({super.key});

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
              image: AssetImage('assets/images/EBC.jpg'),
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 350),
          child: Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextHeading(
                            fontSize: 20,
                            textHeading: 'EBC',
                          ),
                          LocationMonthIconRow(
                              location: 'Def on Earth', date: 'Jan'),
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Text(
                                      'navigate to trails page here')),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.directions),
                              Padding(
                                padding: EdgeInsets.only(left: 2.0),
                                child: AppText(
                                  text: 'Get Directions',
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
                      constraints: BoxConstraints(minHeight: 100),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 130, 200, 133)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Row(children: [
                          Column(
                            children: [
                              AppText(text: 'Rating'),
                              Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 233, 217, 74),
                              ),
                            ],
                          ),
                          Container(
                            height: 70,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 0,
                            ),
                          ),
                          Column(
                            children: [
                              AppText(text: 'Members'),
                              AppText(text: 'Display Members here')
                            ],
                          )
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

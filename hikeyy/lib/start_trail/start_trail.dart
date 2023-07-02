import 'package:flutter/material.dart';
import 'package:hikeyy/start_trail/widgets/collapseable_options.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../widgets/app_buttons.dart';

class StartTrail extends StatefulWidget {
  const StartTrail({super.key});

  @override
  State<StartTrail> createState() => _StartTrailState();
}

class _StartTrailState extends State<StartTrail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Navigator.of(context).pop();
                            },
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: AppText(
                      text: '*enter group name*',
                      fontSize: 20,
                      color: AppColor.primaryColor,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
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
                  constraints: BoxConstraints(maxHeight: 200, maxWidth: 295),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          image: AssetImage('assets/images/EBC.jpg'),
                          fit: BoxFit.cover,
                        )),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
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
                        text: 'Destination Name',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                        top: 100,
                        left: 250,
                        child: Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )),
                    Padding(
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
                        child: AppText(
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
              CollapsibleOptions(),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: AppButtons(
                    onPressed: () {},
                    child: AppText(
                      text: 'Nearby Devices',
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

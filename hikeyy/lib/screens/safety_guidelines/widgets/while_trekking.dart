import 'package:flutter/material.dart';

import '../../../widgets/app_colors.dart';
import '../../../widgets/app_texts.dart';

class WhileTrekking extends StatelessWidget {
  const WhileTrekking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 40.0, left: 10, top: 10, right: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: const Offset(0, 3),
                ),
              ]),
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_walk,
                        color: AppColor.primaryDarkColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: AppText(
                          text: 'While Trekking',
                          color: AppColor.primaryDarkColor,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'You will regularly have to pass by mules and yaks while trekking. Always stay on the mountain side while you wait for them to pass and do not get close to any ridges. Mules are yaks often carry heavy and wide loads so they may accidentally kick you off the mountain, if you’re not careful enough.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'Do not drink alcohol. It dehydrates you and thus increases the risk of altitude sickness if above 3,000 m.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text: 'Always trek with a friend, or guide.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'While trekking above 3,000 m do not ascend too fast. Generally it is not recommended to ascend more than 3-500 m per day as doing so will significantly increase the risk of Acute Mountain Sickness (AMS).'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'Always carry warm clothes and rain kit, in case of sudden change in weather.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'Lots of sun and much walking are factors that will quickly dehydrate and de-energize you. Please therefore always have enough water and snacks nearby. Staying hydrated will help to avoid getting altitude sickness.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'Bring a map, compass and potentially a GPS so that you always know your location (these items are mostly relevant in the more remote trekking regions of Nepal).'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 117, 117),
                        text:
                            'Listen to the advice provided by your guide and trekking agency.'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

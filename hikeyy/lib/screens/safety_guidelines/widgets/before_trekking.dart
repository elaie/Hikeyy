import 'package:flutter/material.dart';

import '../../../widgets/app_colors.dart';
import '../../../widgets/app_texts.dart';

class BeforeTrekking extends StatelessWidget {
  const BeforeTrekking({
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
                          text: 'Before Trekking',
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
                            'Make sure you have proper clothing for all weather conditions. Please be prepared for adverse weather conditions and apply the mantra “better safe than sorry”.'),
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
                            "Have insurance in place so that the expenses for a helicopter emergency evacuation or other emergency situations are covered, if needed. Please bring the insurance details with you."),
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
                            "Personal hygiene is important in order not to get sick. Hand sanitizer or disinfection gel will get you far."),
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
                            "Bring first aid kit, especially if you are trekking alone. Generally we highly recommend to always bring a guide while trekking in the Himalayas."),
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
                            "While trekking may sound cold, during the long days of hiking you may get plenty of sun. Therefore always bring sunscreen, sunglasses and perhaps even a sun hat."),
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
                            "Bring a torch. Electricity is scarce when “out there”."),
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
                            "If you trekking route ascends higher than 3,000 m, please read carefully about Altitude Sickness. More information can be found below."),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

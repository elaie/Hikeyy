import 'package:flutter/material.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/app_texts.dart';

class HelpLinePage extends StatefulWidget {
  const HelpLinePage({super.key});

  @override
  State<HelpLinePage> createState() => _HelpLinePageState();
}

class _HelpLinePageState extends State<HelpLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const AppText(
                    text: 'Helpline Numbers',
                    fontSize: 20,
                    color: AppColor.primaryDarkColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 40.0, left: 20, top: 10, right: 20),
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
                    child: Column(
                      children: [
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Police (Emergency) '),
                          subtitle: AppText(text: '100'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14,
                              text: 'Tourist Police (Bhrikuti Mandap) '),
                          subtitle: AppText(text: '01 4226359/4226403'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(fontSize: 14, text: 'Blood Bank'),
                          subtitle: AppText(text: '01 4225344'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14,
                              text:
                                  'Himalayan Rescue Association (Tridevi Marg)'),
                          subtitle: AppText(text: '01 4262746'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14,
                              text: 'Tribhuvan International Airport (TIA)'),
                          subtitle: AppText(text: '01 4472256/4472257'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(fontSize: 14, text: 'Night Taxi'),
                          subtitle: AppText(text: '01 4224374, 4224375'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Nepal Tourism Board'),
                          subtitle: AppText(text: '01 4256909/4256229'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Ambulance, Bishal Bazaar'),
                          subtitle: AppText(text: '01 4244121'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Ambulance Nepal Chamber'),
                          subtitle: AppText(text: '01 4230213/4222890'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Ambulance, Paropakar'),
                          subtitle: AppText(text: '01 4251614/4260869'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Ambulance, Red Cross'),
                          subtitle: AppText(text: '01 4228094'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14,
                              text:
                                  'Ambulance, Bhagawan Mahavir Jain Niketan 01'),
                          subtitle: AppText(text: '4418619/4422280'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(fontSize: 14, text: 'Bir Hospital'),
                          subtitle: AppText(text: '01 4226963'),
                        ),
                        ListTile(
                          minLeadingWidth: 5,
                          leading: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          title: AppText(
                              fontSize: 14, text: 'Patan Hospital (Lagankhel)'),
                          subtitle: AppText(text: '01 5522278/5522266'),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }
}

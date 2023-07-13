import 'package:flutter/material.dart';

import '../../../widgets/app_colors.dart';
import '../../../widgets/app_texts.dart';

class AltitudeSikness extends StatelessWidget {
  const AltitudeSikness({
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
                          text: 'Altitude Sickness',
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
                        fontSize: 14, text: 'What is altitude sickness?'),
                    subtitle: AppText(
                        text:
                            'Altitude illness also known as altitude sickness is a pathological effect of high altitude on humans, caused by acute exposure to low pressure of oxygen at high altitude. Should it occur it will often be above 8,000 ft and may manifest itself in either AMS – Acute Mountain Sickness, or the more serious conditions HACE and/or HAPE. Altitude illness should always be taken serious as ignoring it may ultimately lead to death. In most instances, however, listening to the body and taking the necessary preventative measures, as outlined below, will entirely prevent AMS from occurring, or remove it, if occurred.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14,
                        text: 'What are altitude illness symptoms?'),
                    subtitle: AppText(
                        text:
                            'Nausea\nTiredness\nSleeplessness, or\nDizziness\nFatigue\nSocial withdrawel\nSwelling extremities'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14, text: 'How to prevent altitude illness?'),
                    subtitle: AppText(
                        text:
                            'The best way to prevent altitude sickness is to ascend gradually. When above 3,000 m it is not recommended to ascend more than 300-400 m per day. Even if you’ve not ascended more than 300 m but still feel a headache, tiredness or any other of the above listed altitude sickness symptoms, always take a rest day to further acclimatize. Moreover, keep on drinking enough water so as to stay hydrated. Proper hydration helps to prevent altitude sickness. Please therefore also always stay away from alcohol when trekking. The general water drinking guideline is to drink 1 liter of water per 1,000 m. To exemplify, if at 4,000 m then 4 liter of water should be consumed per day, if at 5,000 m then 5 liter of water etc. Another recommended way to prevent altitude sickness is the use of Diamox (Acetazolamide) pills so as to speed up the acclimatization. As soon as you ascend more than 3,000 m you can start taking 1 pill per day. Alternatively only take Diamox pills if starting to feel any of the altitude sickness symptoms.'),
                  ),
                  ListTile(
                    minLeadingWidth: 5,
                    leading: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    title: AppText(
                        fontSize: 14, text: 'How to treat altitude illness?'),
                    subtitle: AppText(
                        text:
                            '• Always consult a doctor if available.In case of mild altitude sickness symptoms, stay at the same altitude, take it easy, get plenty of sleep, drink enough water and perhaps start to take Diamox pills.\n• In case the altitude symptoms do not get better within 1 day, start to descend.\n• Never let a person suffering from altitude sickness descend alone.In case of serious altitude sickness symptoms start to descend immediately.\n• Consider getting a helicopter emergency evacuation.\n• Serious altitude sickness symptoms may be treated with a Gamow bag which is a inflatable high pressure bag which helps to restore the oxygen level and air pressure.'),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

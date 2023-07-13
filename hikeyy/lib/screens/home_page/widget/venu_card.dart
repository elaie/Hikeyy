import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_texts.dart';

import '../../../widgets/location_month_icon_row.dart';

class VenuCard extends StatelessWidget {
  final String venue;
  final String location;
  final String date;
  final String photourl;
  final String description;
  const VenuCard(
      {Key? key,
      required this.venue,
      required this.location,
      required this.date,
      required this.photourl, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      //width: 340,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 9, // Blur radius
              offset: const Offset(0, 3), // Offset in the x and y direction
            ),
          ],
          image:
              DecorationImage(image: NetworkImage(photourl), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 150.0, right: 10, left: 10, bottom: 10),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Color.fromRGBO(255, 255, 255, 100)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(
                  venue,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              LocationMonthIconRow(location: location, date: date),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
               SizedBox(
                width: 250,
                child: AppText(
                  alignment: TextAlign.center,
                  text:
                      description,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  color: Color.fromARGB(255, 58, 58, 58),
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

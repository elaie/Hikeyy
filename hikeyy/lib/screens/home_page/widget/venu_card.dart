import 'package:flutter/material.dart';

import '../../../widgets/location_month_icon_row.dart';

class VenuCard extends StatelessWidget {
  final String venue;
  final String location;
  final String date;
  final String photourl;
  const VenuCard(
      {Key? key,
      required this.venue,
      required this.location,
      required this.date,
      required this.photourl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 230,
        width: 200,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 3, // Spread radius
                blurRadius: 9, // Blur radius
                offset: const Offset(0, 3), // Offset in the x and y direction
              ),
            ],
            image: DecorationImage(
                image: NetworkImage(photourl), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 90.0, right: 10, left: 10, bottom: 10),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color.fromRGBO(255, 255, 255, 100)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    venue,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                LocationMonthIconRow(location: location, date: date)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

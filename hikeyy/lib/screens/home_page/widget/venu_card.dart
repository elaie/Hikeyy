import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenuCard extends StatelessWidget {
  final String venue;
  final String location;
  final String date;
  const VenuCard(
      {Key? key,
      required this.venue,
      required this.location,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 230,
        width: 200,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/camping.png',
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 140.0, bottom: 10, left: 10, right: 10),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color.fromRGBO(255, 255, 255, 100)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  venue,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.location_on),
                    Text(location),
                    Icon(Icons.calendar_month),
                    Text(date)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LocationMonthIconRow extends StatelessWidget {
  const LocationMonthIconRow({
    super.key,
    required this.location,
    required this.date,
  });

  final String location;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Icon(Icons.location_on),
        Text(location),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.calendar_month),
        ),
        Text(date)
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
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
        Icon(Icons.location_on),
        Text(location),
        Icon(Icons.calendar_month),
        Text(date)
      ],
    );
  }
}

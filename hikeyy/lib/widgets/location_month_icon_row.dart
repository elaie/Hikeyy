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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              Text(
                location,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
              Text(
                '$date days',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

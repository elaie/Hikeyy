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
      color: Colors.grey.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on,color: Colors.green,),
              Text(location,style: TextStyle(color: Colors.green,),),
            ],
          ),

          Row(
            children: [
              Icon(Icons.timer,color: Colors.green,),
              Text('$date days',style: TextStyle(color: Colors.green,),)
            ],
          ),
        ],
      ),
    );
  }
}

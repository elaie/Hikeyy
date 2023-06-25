import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyScheduleCard extends StatelessWidget {
  final groupName;
  final destination;
  final  date;
  const MyScheduleCard({
    super.key,
    this.groupName,
    this.destination,
    this.date,
  });
 // int Date =date*1000
  @override
  Widget build(BuildContext context) {
    //print(date.toDate());
    //print('*********************');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/camping.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Text(
                      groupName,
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.location_on),
                        Text(destination),
                        Icon(Icons.calendar_month_rounded),
                        Text("${date.toDate().year}-${date.toDate().month}-${date.toDate().day}")
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 128, 206, 131),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(child: Text('Joined')),
              )
            ],
          ),
        ),
      ),
    );
  }
}

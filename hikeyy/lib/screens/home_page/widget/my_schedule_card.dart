import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScheduleCard extends StatelessWidget {
  final groupName;
  final destination;
  final date;
  const MyScheduleCard({
    super.key,
    this.groupName,
    this.destination,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
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
                      children: [
                        Icon(Icons.location_on),
                        Text(destination),
                        Icon(Icons.calendar_month_rounded),
                        Text(date)
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

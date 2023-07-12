import 'package:flutter/material.dart';

class MyScheduleCard extends StatelessWidget {
  final dynamic groupName;
  final dynamic destination;
  final dynamic date;
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
          borderRadius: const BorderRadius.all(
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 3, // Spread radius
                        blurRadius: 9, // Blur radius
                        offset: Offset(0, 3), // Offset in the x and y direction
                      ),
                    ],
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
                        Text(
                            "${date.toDate().year}-${date.toDate().month}-${date.toDate().day}")
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 70,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 6, // Blur radius
                        offset: Offset(0, 3), // Offset in the x and y direction
                      ),
                    ],
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

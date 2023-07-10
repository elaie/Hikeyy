import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class StartTrail extends StatefulWidget {
  const StartTrail({super.key});

  @override
  State<StartTrail> createState() => _StartTrailState();
}

class _StartTrailState extends State<StartTrail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: 320,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text('*Map here*'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 15,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                  child: AppTextHeading(
                    textHeading: 'Timeline',
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

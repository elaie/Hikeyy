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
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            AppTextHeading(
              textHeading: '*insert destination name*',
              fontSize: 20,
            ),
            //group members
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 15,
                    ),
                  ),
                ],
              ),
            ),
           //checkpoints
            Text('Connect to devices'),
            Text('public/privete'),
            Text('start trail'),
          ]),
        ),
      ),
    );
  }
}

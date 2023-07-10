import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class UpdateLocation extends StatefulWidget {
  const UpdateLocation({super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  bool hasReached = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: AppText(
                  text: 'Where Have You Reached?',
                  fontSize: 20,
                  color: AppColor.primaryDarkColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Container(
                    child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                            leading: Icon(Icons.location_on),
                            title: AppText(
                              text: 'Checkpoint',
                              fontSize: 20,
                            ),
                            trailing: AppButtons(
                                color: hasReached
                                    ? AppColor.primaryColor
                                    : Colors.red,
                                onPressed: () {
                                  setState(() {
                                    hasReached = !hasReached;
                                  });
                                },
                                child: hasReached
                                    ? Text('Reached!')
                                    : Text('Not Reached'))),
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

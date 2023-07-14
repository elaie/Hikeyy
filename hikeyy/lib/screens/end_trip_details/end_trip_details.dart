import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class EndTripDetails extends StatefulWidget {
  const EndTripDetails({super.key});

  @override
  State<EndTripDetails> createState() => _EndTripDetailsState();
}

class _EndTripDetailsState extends State<EndTripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          text: 'Details',
          fontSize: 20,
          color: AppColor.primaryDarkColor,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  color: AppColor.primaryLightColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(2, 2),
                        spreadRadius: 3.5,
                        blurRadius: 5,
                        color: Colors.grey)
                  ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/icons/completesvg.png'),
                      radius: 70,
                    ),
                    const AppText(
                      text: 'Congratulations!',
                      fontSize: 30,
                    ),
                    const AppText(
                      text: 'You have completed your trail!',
                      fontSize: 15,
                    ),
                    const AppText(
                      text: 'Here are all the details.',
                      fontSize: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  spreadRadius: 3.5,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: 'Total Duration: ',
                                      fontSize: 15,
                                    ),
                                    AppText(
                                      text: '7 Days',
                                      fontSize: 15,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: 'Total Expenses: ',
                                      fontSize: 15,
                                    ),
                                    AppText(
                                      text: 'Rs. 20000',
                                      fontSize: 15,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: 'Total Expenses: ',
                                      fontSize: 15,
                                    ),
                                    AppText(
                                      text: 'Rs. 20000',
                                      fontSize: 15,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  spreadRadius: 3.5,
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(
                                      text: 'Leave a Review: ',
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [TextFormField()],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

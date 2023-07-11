import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_buttons.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class CheckpointDetailPage extends StatefulWidget {
  const CheckpointDetailPage({super.key});

  @override
  State<CheckpointDetailPage> createState() => _CheckpointDetailPageState();
}

class _CheckpointDetailPageState extends State<CheckpointDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                    AppText(
                      text: 'Chommrung',
                      fontSize: 20,
                      color: AppColor.primaryDarkColor,
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  width: 330,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColor.primaryLightColor),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const Image(
                      image: AssetImage('assets/images/EBC.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Altitude',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: '2550 m',
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Lodges',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: '10',
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: AppText(
                              text: 'Network',
                              fontSize: 17,
                              color: AppColor.primaryDarkColor,
                            ),
                          ),
                          AppText(
                            text: 'Available',
                            fontSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: AppButtons(
                      width: 200,
                      onPressed: () {},
                      child: AppText(
                        text: 'Weather',
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: AppText(
                    text: 'Lodges',
                    color: AppColor.primaryDarkColor,
                    fontSize: 20,
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.8),
                      itemBuilder: ((context, index) {
                        return InkWell(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColor.primaryLightColor),
                          ),
                          onTap: () {},
                        );
                      })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

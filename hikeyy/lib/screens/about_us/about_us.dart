import 'package:flutter/material.dart';
import 'package:hikeyy/widgets/app_colors.dart';
import 'package:hikeyy/widgets/app_texts.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: const AppText(
                      text: 'About Us',
                      fontSize: 30,
                      color: AppColor.primaryDarkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Image(image: AssetImage('assets/images/group.png')),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: AppText(
                alignment: TextAlign.center,
                text:
                    "As a team of four passionate developers, we've poured our hearts into creating this app as our final project. Our goal? To bring the joy of hiking right to your fingertips. So lace up your boots, grab your backpack, and let's hit the trails together! "),
          ),
          const AppText(
            text: 'Meet out team!',
            fontSize: 30,
            color: AppColor.primaryDarkColor,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20),
            child: AppText(
                fontSize: 18,
                text:
                    'Pritisha Shrestha\n\nSudeep Shrestha\n\nSanskar Shrestha\n\nSumiran Pokhrel'),
          ),
          const AppTextSubHeading(
              text: 'Nepal College of Information And Technology')
        ],
      )),
    );
  }
}

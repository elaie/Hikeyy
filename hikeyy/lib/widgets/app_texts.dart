import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppTextsHeading extends StatelessWidget {
  final String textHeading;
  final double? fontSize;
  AppTextsHeading({Key? key, required this.textHeading, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textHeading,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
      ),
    );
  }
}

class AppText extends StatelessWidget {
  final String text;
  AppText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
    );
  }
}

class AppTextSubHeading extends StatelessWidget {
  final String text;
  final double? fontSize;
  AppTextSubHeading({Key? key, required this.text, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w500, color: Colors.grey),
    );
  }
}

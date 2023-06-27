import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppTextHeading extends StatelessWidget {
  final String textHeading;
  final double? fontSize;
  final Color? color;
  const AppTextHeading(
      {Key? key, required this.textHeading, this.fontSize, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textHeading,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
      ),
    );
  }
}

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  const AppText({Key? key, required this.text, this.fontSize, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color, fontWeight: FontWeight.bold, fontSize: fontSize),
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

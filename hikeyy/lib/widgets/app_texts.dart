import 'package:flutter/material.dart';

class AppTextHeading extends StatelessWidget {
  final String textHeading;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const AppTextHeading(
      {Key? key,
      required this.textHeading,
      this.fontSize,
      this.color,
      this.maxLines,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textHeading,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        overflow: textOverflow ?? TextOverflow.ellipsis,
        color: color,
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
      ),
    );
  }
}

class AppText extends StatelessWidget {
  final TextAlign? alignment;
  final String text;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const AppText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color,
      this.maxLines,
      this.textOverflow,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      maxLines: maxLines ?? 100,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        overflow: textOverflow ?? TextOverflow.ellipsis,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}

class AppTextSubHeading extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? fontSize;
  final TextOverflow? textOverflow;

  const AppTextSubHeading({
    Key? key,
    required this.text,
    this.fontSize,
    this.maxLines,
    this.textOverflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 100,
      style: TextStyle(
          overflow: textOverflow ?? TextOverflow.ellipsis,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.grey),
    );
  }
}

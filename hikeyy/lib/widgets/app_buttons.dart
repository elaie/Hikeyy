import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppButtons extends StatelessWidget {
  final Color? color;
  final Widget child;
  final Function onPressed;

  const AppButtons(
      {super.key, required this.onPressed, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const <BoxShadow>[
        BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 1,
            blurRadius: 3),
      ], borderRadius: BorderRadius.circular(30)),
      height: 40,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(color ?? AppColor.primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        onPressed: onPressed as void Function()?,
        child: child,
      ),
    );
  }
}

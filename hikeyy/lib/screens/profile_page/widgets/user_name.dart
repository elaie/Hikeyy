import 'package:flutter/cupertino.dart';

class UserName extends StatelessWidget {
  const UserName({
    super.key,
    required this.name,
  });

  final name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}

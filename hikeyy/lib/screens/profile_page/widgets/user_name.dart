import 'package:flutter/cupertino.dart';

class UserName extends StatelessWidget {
  const UserName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}

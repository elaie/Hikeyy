import 'package:flutter/material.dart';

class Bio extends StatelessWidget {
  const Bio({
    super.key,
    required this.bio,
  });

  final String bio;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 230,
      child: Column(
        children: [
          Text(
            bio,
            style: const TextStyle(fontSize: 16, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

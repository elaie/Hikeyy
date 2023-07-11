import 'package:flutter/material.dart';

import '../edit_profile.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      right: 80,
      child: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EditProfile()));
        },
        icon: const Icon(Icons.edit),
        color: Colors.green,
      ),
    );
  }
}

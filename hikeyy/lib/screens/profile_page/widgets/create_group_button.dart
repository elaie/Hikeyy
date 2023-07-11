import 'package:flutter/material.dart';

import '../create_group.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      child: SizedBox(
        height: 45,
        width: 220,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CreateGroup()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              (Colors.green),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          child: const Text('Create Group'),
        ),
      ),
    );
  }
}

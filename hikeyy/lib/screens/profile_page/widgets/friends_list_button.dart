import 'package:flutter/material.dart';

import '../friends_list.dart';

class FriendsListButton extends StatelessWidget {
  const FriendsListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250,
      left: 80,
      child: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FriendsList()));
        },
        icon: const Icon(
          Icons.people,
          color: Colors.green,
        ),
      ),
    );
  }
}

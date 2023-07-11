import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.pfp,
  });

  final dynamic pfp;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      child: GestureDetector(
          onTap: () {
           // print('image pressed');
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              //for circle outline on pp
              border: Border.all(
                width: 3,
                color: Colors.green,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: pfp == ' '
                ? Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(200),
                        image: const DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/profile.png'))),
                  )
                : Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(200),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(pfp),
                        )),
                  ),
          )),
    );
  }
}

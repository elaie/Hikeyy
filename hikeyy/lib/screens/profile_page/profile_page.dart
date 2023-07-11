import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/profile_page/widgets/bio.dart';
import 'package:hikeyy/screens/profile_page/widgets/edit_button.dart';
import 'package:hikeyy/screens/profile_page/widgets/friends_list_button.dart';
import 'package:hikeyy/screens/profile_page/widgets/group_list.dart';
import 'package:hikeyy/screens/profile_page/widgets/logout_button.dart';
import 'package:hikeyy/screens/profile_page/widgets/profile_picture.dart';
import 'package:hikeyy/screens/profile_page/widgets/user_name.dart';
import 'package:hikeyy/screens/profile_page/widgets/white_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<DocumentSnapshot?> getDocumentByUID(String uid) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (snapshot.exists) {
        // Document exists, return the snapshot
        return snapshot;
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      // ignore: avoid_print
      print('Error: $e');
      return null;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(auth.currentUser!.uid)
              .get(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data();
              var name = data!['UserName'];
              var pfp = data['pfpUrl'];
              var bio = data['Bio'];
              return SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/green_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SizedBox(
                    height: 700,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        //for white container
                        const WhiteContainer(),
                        //username
                        UserName(name: name),
                        //profile picture
                        ProfilePicture(pfp: pfp),
                        //bio
                        Bio(bio: bio),
                        //frieds list
                        const FriendsListButton(),
                        const Positioned(
                            top: 290,
                            left: 80,
                            child: Text(
                              'My Friends',
                              style: TextStyle(fontSize: 12),
                            )),
                        const Positioned(
                            top: 290,
                            right: 80,
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 12),
                            )),

                        //edit button
                        const EditButton(),

                        //group list
                        GroupList(auth: auth),
                        //logout button
                        const LogoutButton(),
                        //create group button
                       // const CreateGroupButton(),
                        //Highlights
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

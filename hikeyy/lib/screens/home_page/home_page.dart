import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikeyy/screens/home_page/widget/my_schedule_card.dart';
import 'package:hikeyy/screens/home_page/widget/trails.dart';
import 'package:hikeyy/screens/home_page/widget/venu_card.dart';
import 'package:hikeyy/screens/login_signup/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hikeyy/screens/profile_page/MyFriendRequest.dart';
import 'package:hikeyy/screens/profile_page/widgets/group_list.dart';
import 'package:hikeyy/screens/venue_details/venue_details_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:hikeyy/screens/See all/see_all_recommended.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  final ImagePicker _picker = ImagePicker();

  // Pick multiple images
  final List<XFile>? pickedFiles =
      await _picker.pickMultiImage(imageQuality: 80);

  if (pickedFiles != null) {
    for (var i = 0; i < pickedFiles.length; i++) {
      File image = File(pickedFiles[i].path);
      images.add(image);
    }
  }

  return images;
}

void uploadImages(List<File> images) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];

  for (var i = 0; i < images.length; i++) {
    File image = images[i];

    // Create a unique filename for each image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a reference to the location you want to upload to in Firebase Storage
    Reference ref = storage.ref().child('images/$fileName');

    // Upload the file to Firebase Storage
    UploadTask uploadTask = ref.putFile(image);

    // Get the download URL once the upload is complete
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    imageUrls.add(imageUrl);
  }
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String UserName = '';
  @override
  Future<void> getUserName() async{
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('Users').doc(auth.currentUser!.uid).get();
    setState(() {
      UserName=data['UserName'];
    });
  }
  @override
  void initState(){
    // TODO: implement initState
    getUserName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        drawer: const Drawer(
          child: Icon(Icons.add),
        ),
        //extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/green_background.png'),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                child: const Icon(Icons.add),
                                onTap: () =>
                                    _scaffoldkey.currentState!.openDrawer()),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Text(
                                'WELCOME '+ UserName,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: const Icon(Icons.notifications),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MyFriendRequest()));
                          },
                        ),
                        // Icon(Icons.notifications),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Container(
                      //height: 1000,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                          color: Colors.grey.shade200.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                        ),
                        child: SingleChildScrollView(
                          //  scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 25.0, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recommended',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17),
                                    ),
                                    Text('See all')
                                  ],
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Trails')
                                    .snapshots(),
                                builder: (context, snapshots) {
                                  if (snapshots.hasError) {
                                    return Text('Error: ${snapshots.error}');
                                  }
                                  if (!snapshots.hasData) {
                                    return const Text('No data available');
                                  }
                                  return SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 200.0,
                                          child: ListView.builder(
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              padding: const EdgeInsets.all(10),
                                              itemCount:
                                                  snapshots.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                var data = snapshots
                                                        .data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>;
                                                String id = snapshots
                                                    .data!.docs[index].id;
                                                return Row(
                                                  children: [
                                                    GestureDetector(
                                                      child: VenuCard(
                                                        venue: data['Name']
                                                            .toString(),
                                                        location: 'Nepal',
                                                        date: 'july',
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                VenueDetailsPage(id: id,),
                                                            // Trails(
                                                            //     id: id),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'My Schedule',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 17),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        List<File> selectedImages =
                                            await pickImages();
                                        uploadImages(selectedImages);
                                        // Handle click event here
                                        // print("SEE ALL TAPPED");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => see_all_recommended(),
                                        //   ),
                                        // );
                                        print('Text clicked');
                                      },
                                      child: const Text(
                                        'See all',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 550),
                                  child: GroupList(auth: auth)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_page/home_page.dart';
import '../profile_page/profile_page.dart';
import '../search_page/search_page.dart';

class Dashboard extends StatefulWidget {
  final Widget page;
  const Dashboard({super.key, required this.page});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget pageA=CircularProgressIndicator();
  int _selectedPageIndex = 0;
  List<Widget> _pages=[];



  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop().then((value) {
                  false;
                }),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  getTokenId() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'TokenId': fcmToken}).then((value) {
      print(fcmToken);
      print('@@@@@@@@@@@@@@@@@@@@@');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenId();
    pageA=widget.page;
    _pages = [
      pageA,
      const SearchPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: _pages[_selectedPageIndex],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            child: BottomNavigationBar(
              //type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image(
                      height: 30,
                      width: 30,
                      image: AssetImage('assets/icons/home.png')),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image(
                      height: 30,
                      width: 20,
                      image: AssetImage('assets/icons/search.png')),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Image(
                      height: 30,
                      width: 20,
                      image: AssetImage('assets/icons/profile.png')),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedPageIndex,
              selectedItemColor: Colors.black,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}

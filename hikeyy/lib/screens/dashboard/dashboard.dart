import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home_page/home_page.dart';
import '../profile_page/profile_page.dart';
import '../search_page/search_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];
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

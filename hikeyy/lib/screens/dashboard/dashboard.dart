import 'package:flutter/material.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedPageIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 215, 212, 212),
                spreadRadius: 2,
                blurRadius: 3),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
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
    );
  }
}

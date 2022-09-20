import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/screens/profile_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static List<Widget> widgetOptions = <Widget>[
    const Profile(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Constants.primarycolor,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/icons/dashboard.png"),
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/icons/reports.png"),
              ),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/icons/profile.png"),
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

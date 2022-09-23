// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';

import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/screens/admin_home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static List<Widget> widgetOptions = <Widget>[
    const AdminHomeScreen(),
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
      body: Stack(
        children: [
          widgetOptions.elementAt(_selectedIndex),
          Positioned(
            left: MediaQuery.of(context).size.width * .045,
            right: MediaQuery.of(context).size.width * .03,
            bottom: 19,
            child: Container(
              height: 77,
              width: 197,
              margin: const EdgeInsets.fromLTRB(100, 0, 100, 5),
              foregroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100.0),
                  topRight: Radius.circular(100.0),
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
                child: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/icons/home.png"),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage("assets/images/icons/profileicon.png"),
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  enableFeedback: true,
                  backgroundColor: Constants.primarycolor,
                  selectedItemColor: Constants.textcolor,
                  unselectedItemColor: Constants.greyColor,
                  onTap: _onItemTapped,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

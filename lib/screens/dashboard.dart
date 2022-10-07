// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:e_voting/models/user_data.dart';

import 'package:e_voting/providers/firestore_provider.dart';

import 'package:e_voting/screens/voter_home_screen.dart';

import 'package:provider/provider.dart';
import 'package:e_voting/utils/constants.dart';

import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/screens/admin_home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          FutureBuilder<UserData?>(
            future: context.read<FirestoreProvider>().getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error in data"),
                );
              }
              return [
                (snapshot.data!.role == Role.admin)
                    ? const AdminHomeScreen()
                    : VoterHomeScreen(
                        data: snapshot.data!,
                      ),
                const ProfileScreen(),
              ].elementAt(_selectedIndex);
            },
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * .030,
            right: MediaQuery.of(context).size.width * .01,
            bottom: 19,
            child: Container(
              height: 77,
              width: 250,
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

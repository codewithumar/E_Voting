import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/button.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Constants.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AdminScreenButton("party", "Create Party"),
            AdminScreenButton("election", "Create Election"),
          ],
        ),
      ),
    );
  }
}

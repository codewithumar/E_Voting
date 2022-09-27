import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/electiontiles.dart';

import 'package:e_voting/widgets/adminscreenbutton.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? AppBar(
              centerTitle: true,
              title: const Text("Home"),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Constants.colors,
                  ),
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdminScreenButton(
                    "parties",
                    "Create Party",
                    type: AdminButton.party,
                  ),
                  AdminScreenButton(
                    "election",
                    "Create Election",
                    type: AdminButton.election,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const ElectionTiles(),
              const ElectionTiles(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

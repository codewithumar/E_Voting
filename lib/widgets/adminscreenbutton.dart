// ignore_for_file: must_be_immutable

import 'package:e_voting/screens/create_election_screen.dart';
import 'package:e_voting/screens/parties_screen.dart';
import 'package:e_voting/widgets/electiontiles.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';

class AdminScreenButton extends StatelessWidget {
  AdminScreenButton(this.iconname, this.text, {required this.type, super.key});
  String iconname;
  String text;
  AdminButton type;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: (type == AdminButton.party)
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PartiesScreen(),
                  ),
                );
              }
            : (type == AdminButton.election)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateElectionScreen(),
                      ),
                    );
                  }
                : null,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
                blurStyle: BlurStyle.solid,
              ),
            ],
            color: Constants.adminScreenButtonColor,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          height: height * .2,
          width: width * .4,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  AssetImage("assets/images/icons/$iconname.png"),
                  color: Constants.adminiconcolor,
                  size: 40,
                ),
                const SizedBox(height: 10.5),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xff060C05),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/screens/edit_election_screen.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/widgets/stackedwidget.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

enum AdminButton { party, election }

class AdminElectionTiles extends StatelessWidget {
  AdminElectionTiles({required this.data, super.key});
  ElectionModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
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
            Radius.circular(10),
          ),
        ),
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height * .15
            : (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height * .15
                : null,
        width: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.width * .9
            : (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width * .9
                : null,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.electioname,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  PopupMenuButton<PopMenuOption>(
                    elevation: 4,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    onSelected: (value) {
                      if (value == PopMenuOption.edit) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditElectionScreen(
                              data: data,
                            ),
                          ),
                        );
                      }
                      if (value == PopMenuOption.delete) {
                        FirestoreService.deleteElection(data);
                      }
                    },
                    itemBuilder: (BuildContext context) => const [
                      PopupMenuItem<PopMenuOption>(
                        height: 26.5,
                        value: PopMenuOption.edit,
                        child: Center(
                          child: Text("Edit",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              )),
                        ),
                      ),
                      PopupMenuItem<PopMenuOption>(
                        height: 26.5,
                        value: PopMenuOption.delete,
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildStackedImages(),
                  const Text(
                    " +5",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(
                    child: Text(""),
                  ),
                  Text(
                    data.electionmaxvotetime,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

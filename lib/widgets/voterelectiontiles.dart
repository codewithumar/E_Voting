// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/providers/firestore_provider.dart';
import 'package:e_voting/screens/voting_screen.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/widgets/stackedwidget.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:provider/provider.dart';

enum AdminButton { party, election }

class VoterElectionTiles extends StatefulWidget {
  const VoterElectionTiles({required this.data, super.key});
  final ElectionModel data;

  @override
  State<VoterElectionTiles> createState() => _VoterElectionTilesState();
}

class _VoterElectionTilesState extends State<VoterElectionTiles> {
  @override
  Widget build(BuildContext context) {
    DateTime electiontime = DateTime(
      DateTime.parse(widget.data.electiondate).year,
      DateTime.parse(widget.data.electiondate).month,
      DateTime.parse(widget.data.electiondate).day,
      DateTime.parse(widget.data.electionstarttime).hour,
      DateTime.parse(widget.data.electionstarttime).minute,
      DateTime.parse(widget.data.electionstarttime).second,
    );
    // log(electiontime.toString());

    //Duration test = electiontime.difference(DateTime.now());

    // log(test1.toString());
    // log(test.toString());
    DateTime remaingtime = electiontime.subtract(
      Duration(
        days: DateTime.now().day,
        hours: DateTime.now().hour,
        minutes: DateTime.now().minute,
        seconds: DateTime.now().second,
      ),
    );
    // DateTime remaingtime = DateTime(DateTime.now().year, DateTime.now().month,
    //     test.inDays, test.inHours, test.inMinutes, test.inSeconds);
    log(remaingtime.toString());

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VotingScreen(
              data: widget.data,
            ),
          ),
        );
      },
      child: Padding(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.electioname,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Text(
                      "Upcoming",
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
                      "${remaingtime.hour}h ${remaingtime.minute}m left",
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
      ),
    );
  }
}

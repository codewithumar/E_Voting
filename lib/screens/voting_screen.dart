import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/widgets/votingscreentile.dart';

import '../utils/constants.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({required this.data, super.key});
  final ElectionModel data;

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          myDuration = Duration(
            hours: DateTime.parse(widget.data.electionendtime).hour,
            minutes: DateTime.parse(widget.data.electionendtime).minute,
            seconds: DateTime.parse(widget.data.electionendtime).second,
          );
        });
      },
    );
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(days: 1));
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(
      () {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? AppBar(
              centerTitle: true,
              title: Text(widget.data.electioname),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 35, 0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Time left to cast a vote",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.popupmenutextcolor),
                      ),
                      Container(
                        height: 40,
                        width: 170,
                        decoration: const BoxDecoration(
                          color: Constants.adminScreenButtonColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$hours:$minutes:$seconds',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 32),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 700,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Parties")
                    .snapshots()
                    .map(
                      (event) => event.docs
                          .map(
                            (e) => PartyModel.fromJson(
                              e.data(),
                            ),
                          )
                          .toList(),
                    ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error in Data"),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return VotingTiles(
                          partydata: data[index],
                          electiondata: widget.data,
                        );
                      },
                    );
                  }
                  return const Text("No Data");
                },
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

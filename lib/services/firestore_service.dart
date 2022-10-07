import 'dart:developer';

import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/models/votecountmodel.dart';
import 'package:e_voting/services/firebase_auth_service.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user_data.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuthService();
  static Stream<UserData> readUser() => _firestore
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .map(
        (event) => UserData.fromJson(
          event.data()!,
        ),
      );

  static Future<UserData?> getUser() async {
    try {
      final jsonData = await _firestore
          .collection(FirebaseAuthService().user!.email!)
          .doc(FirebaseAuthService().user!.uid)
          .get();
      log(jsonData.data().toString());
      return UserData.fromJson(jsonData.data()!);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Stream? getEections() {
    try {
      final data =
          FirebaseFirestore.instance.collection("election").snapshots().map(
                (event) => event.docs
                    .map(
                      (e) => ElectionModel.fromJson(
                        e.data(),
                      ),
                    )
                    .toList(),
              );

      return data;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future savePassToFirestore(UserData user) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(uid);
    user.id = uid;
    await docUser.set(user.toJson());
  }

  static Future<void> createparty(PartyModel partydata) async {
    try {
      final partyDoc =
          FirebaseFirestore.instance.collection("Parties").doc(partydata.id);

      partyDoc.set(
        partydata.toJson(),
      );
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  static Future<void> createElection(ElectionModel data) async {
    final docref = _firestore.collection("election").doc();
    data.id = docref.id;
    log(data.toJson().toString());
    await docref
        .set(
          data.toJson(),
        )
        .then(
          (value) => Fluttertoast.showToast(msg: "Election Created"),
        );
  }

  static Future<void> updateElection(ElectionModel data) async {
    final docref = _firestore.collection("election").doc(data.id);
    await docref.update(data.toJson());
  }

  static Future<void> deleteElection(ElectionModel data) async {
    final docref = _firestore.collection("election").doc(data.id);
    await docref.delete().then(
          (value) => Fluttertoast.showToast(msg: "Deleted"),
        );
  }

  static Future<Role> checkUserRole() async {
    final auth = FirebaseAuth.instance;
    late Role role;
    await FirebaseFirestore.instance
        .collection(auth.currentUser!.email!)
        .doc(auth.currentUser!.uid)
        .get()
        .then(
      (value) {
        final v = value.data()!['role'];
        role = Constants.convertStringToRole(v);
      },
    );

    return role;
  }

  static Future<void> submitVote(
    PartyModel partydata,
    VoteCountModel votecountmodel,
    ElectionModel electiondata,
  ) async {
    final docref = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("voting")
        .doc(
          electiondata.id,
        );

    docref.set(
      votecountmodel.toJson(),
    );
  }

  static Future<String> checkvoted() async {
    final docref = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("voting")
        .doc()
        .id;

    log(docref);
    return docref;
  }
}

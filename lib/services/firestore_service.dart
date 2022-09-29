import 'dart:developer';

import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/services/firebase_auth_service.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future savePassToFirestore(UserData user) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(uid);
    user.id = uid;
    await docUser.set(user.toJson());
  }

  static Future createparty(PartyModel partydata) async {
    final partyDoc = FirebaseFirestore.instance
        .collection("Parties")
        .doc(partydata.partyname);
    await partyDoc.set(
      partydata.toJson(),
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
}

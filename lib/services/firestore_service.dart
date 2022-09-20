import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_data.dart';

class FirestoreServices {
  static Stream<List<UserData>> readUsers() => FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => UserData.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );

  static Future savePassToFirestore(UserData user) async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc();
    user.id = docUser.id;
    final json = user.toJson();
    log('json = $json, userid = ${user.id}');
    await docUser.set(json);
  }
}

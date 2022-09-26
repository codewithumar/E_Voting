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
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(uid);
    user.id = uid;
    log(docUser.id.toString());
    await docUser.set(user.toJson());
  }

  static Future<String> checkUserRole() async {
    final auth = FirebaseAuth.instance;
    String role = "";
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc();
    log(docUser.id.toString());
    await FirebaseFirestore.instance
        .collection(auth.currentUser!.email!)
        .doc(auth.currentUser!.uid)
        .get()
        .then(
      (value) {
        role = value.data()!['role'];
      },
    );

    return role;
  }
}

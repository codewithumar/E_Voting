import 'dart:developer';
import 'package:e_voting/models/election_model.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/services/firestore_service.dart';

class FirestoreProvider with ChangeNotifier {
  UserData? _user;
  Stream? _elections;

  Future<void> createelection(ElectionModel data) async {
    try {
      await FirestoreService.createelection(data);
    } catch (e) {
      log(
        e.toString(),
      );
    }
  }

  Stream<UserData?>? readUsers() {
    try {
      final data = FirestoreService.readUser();
      return data;
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return null;
  }

  Stream getElections() {
    try {
      _elections = FirestoreService.getEections();
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return _elections!;
  }

  Future<UserData> getUser() async {
    try {
      _user = await FirestoreService.getUser();
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return _user!;
  }
}

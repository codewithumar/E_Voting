import 'dart:developer';

import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class FirestoreProvider with ChangeNotifier {
  UserData? _user;

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

import 'dart:developer';

import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';

class FirestoreProvider with ChangeNotifier {
  UserData? _user;
  Role _role = Role.voter;
  Role get role => _role;
  Future<UserData> getUser() async {
    try {
      _user = await FirestoreService.getUser();
      _role = _user!.role;
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
    return _user!;
  }
}

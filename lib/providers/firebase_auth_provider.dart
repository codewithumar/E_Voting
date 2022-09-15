import 'package:e_voting/services/firebase_auth_service.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _authservices = FirebaseAuthService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signInwithEmailandPassword(String email, String password) async {
    _isLoading = true;

    try {
      await _authservices.signinWithEmailAndPassword(email, password);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signupwithEmailandPassword(String email, String password) async {
    _isLoading = true;

    try {
      await _authservices.signupWithEmailAndPassword(email, password);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}

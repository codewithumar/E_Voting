import 'package:e_voting/services/firebase_auth_service.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthProvider with ChangeNotifier {
  final _authservices = FirebaseAuthService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasError = false;
  bool _isProfileCreation = false;
  bool _isSignUpLoading = false;
  bool _isGoogleLoading = false;
  bool _isGoogleSignUpLoading = false;
  bool _isFacebookLoading = false;
  String _errorMsg = '';

  bool get hasError => _hasError;
  String get errorMsg => _errorMsg;
  bool get isSignUpLoading => _isSignUpLoading;
  bool get isGoogleLoading => _isGoogleLoading;
  bool get isFacebookLoading => _isFacebookLoading;
  bool get isProfileCreation => _isProfileCreation;
  bool get isGoogleSignUpLoading => _isGoogleSignUpLoading;

  Future<void> signInwithEmailandPassword(String email, String password) async {
    _isLoading = true;

    try {
      await _authservices.signinWithEmailAndPassword(email, password);
    } on WrongPasswordException catch (e) {
      _errorMsg = e.message;
      _hasError = true;
    } on UserNotFoundException catch (e) {
      _errorMsg = e.message;
      _hasError = true;
    } on UnkownException {
      _errorMsg = 'Something went wrong';
      _hasError = true;
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

import 'package:flutter/material.dart';

import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/services/firebase_auth_service.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _wait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF027314),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Image(
                  image: AssetImage('assets/images/splashicon.png'),
                ),
              ),
              SizedBox(height: 25),
              Text(
                'E-Voting',
                style: TextStyle(
                  fontSize: 40,
                  color: Constants.textcolor,
                ),
              ),
              Text(
                'Cast Your Vote Online',
                style: TextStyle(
                  fontSize: 14,
                  color: Constants.textcolor,
                ),
              ),
            ]),
      ),
    );
  }

  Future<void> _wait() async {
    await Future.delayed(const Duration(seconds: 3), () {
      final auth = FirebaseAuthService();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              (auth.user == null) ? const LoginScreen() : const Profile(),
        ),
      );
    });
  }
}

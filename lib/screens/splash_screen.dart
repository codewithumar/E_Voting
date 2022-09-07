import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Future<void> wait(BuildContext context) async {
  await Future.delayed(
    const Duration(seconds: 3),
  );
  move(context);
}

void move(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false);
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    wait(context);
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
                  color: Color(
                    0xffFBFAFA,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

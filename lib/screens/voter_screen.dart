import 'package:e_voting/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VoterScreen extends StatelessWidget {
  const VoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Voter Screen"),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text("sign out"),
            ),
          ],
        ),
      ),
    );
  }
}

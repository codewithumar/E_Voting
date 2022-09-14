import 'package:e_voting/services/user_simple_preferences.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:e_voting/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Voting',
      theme: ThemeData(
        fontFamily: "Mulish",
        primarySwatch: Colors.teal,
      ),
      home: const SplashScreen(),
    );
  }
}

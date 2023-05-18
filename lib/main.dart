import 'package:e_voting/providers/firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/screens/splash_screen.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:e_voting/utils/constants.dart';

import 'package:e_voting/providers/firebase_auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirestoreProvider>(
          create: (context) => FirestoreProvider(),
        ),
        ChangeNotifierProvider<FirebaseAuthProvider>(
          create: (context) => FirebaseAuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appname,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: "Mulish",
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

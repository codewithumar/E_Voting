import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:flutter/material.dart';

import '../widgets/sign_up_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff027314),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                const SignUpFields(
                  label: 'Name',
                  labelText: 'Enter Your Name',
                ),
                const SignUpFields(
                  label: 'CNIC',
                  labelText: '37406-3675252-1',
                ),
                const SignUpFields(
                  label: 'Date of Expiry',
                  labelText: '02/22',
                ),
                const SignUpFields(
                  label: 'Email',
                  labelText: 'example@gmail.com',
                ),
                const SignUpFields(
                  label: 'Password',
                  labelText: '***************',
                  obscure: true,
                ),
                const SignupLoginButton(btnText: 'Continue'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.greyColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(
                            color: Constants.primarycolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

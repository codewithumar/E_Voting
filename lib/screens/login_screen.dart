import 'package:e_voting/screens/profile.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:e_voting/screens/signup_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/sign_up_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double height = MediaQuery.of(context).size.height;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final auth = FirebaseAuth.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff027314),
                  ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.greyColor,
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                InputField(
                  label: 'Email',
                  labelText: 'example@gmail.com',
                  controller: emailcontroller,
                ),
                InputField(
                  label: 'Password',
                  labelText: '***************',
                  controller: passwordcontroller,
                  obscure: true,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.62),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xff027314),
                    ),
                  ),
                ),
                SignupLoginButton(btnText: 'Signin', function: loginuser),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.greyColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          " Sign up",
                          style: TextStyle(
                            color: Constants.primarycolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 30),
                //   child: Row(children: const <Widget>[
                //     Expanded(
                //         child: Divider(
                //       thickness: 1,
                //       color: Constants.greyColor,
                //     )),
                //     Text(
                //       " or ",
                //       style: TextStyle(
                //         color: Constants.greyColor,
                //         fontSize: 16,
                //       ),
                //     ),
                //     Expanded(
                //         child: Divider(
                //       thickness: 1,
                //       color: Constants.greyColor,
                //     )),
                //   ]),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [buildGoogleLogin(), buildFacebookLogin()],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    )
        .then(
      (value) {
        Fluttertoast.showToast(msg: "Logged in Successfully");
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Profile(),
            ),
            (route) => false);
      },
    ).onError(
      (error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      },
    );
  }
}

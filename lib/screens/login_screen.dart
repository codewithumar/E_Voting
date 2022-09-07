import 'package:e_voting/screens/profile.dart';
import 'package:e_voting/screens/signup_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/sign_up_fields.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
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
                const SignUpFields(
                  label: 'Email',
                  labelText: 'example@gmail.com',
                ),
                const SignUpFields(
                  label: 'Password',
                  labelText: '***************',
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
                // ElevatedButton(
                //   onPressed: (() => Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => const Profile(),
                //         ),
                //       )),
                //   child: const SignupLoginButton(
                //     btnText: 'Signin',
                //   ),
                // ),
                const SignupLoginButton(
                  btnText: 'Signin',
                ),
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(children: const <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Constants.greyColor,
                    )),
                    Text(
                      " or ",
                      style: TextStyle(
                        color: Constants.greyColor,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Constants.greyColor,
                    )),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [buildGoogleLogin(), buildFacebookLogin()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFacebookLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.greyColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: IconButton(
        icon: Image.asset('assets/images/icons/facebook.png'),
        onPressed: () {},
      ),
    );
  }

  Widget buildGoogleLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Constants.greyColor,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: IconButton(
        icon: Image.asset('assets/images/icons/google.png'),
        onPressed: () {},
      ),
    );
  }
}

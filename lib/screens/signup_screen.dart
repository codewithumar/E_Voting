import 'package:e_voting/screens/create_profile.dart';
import 'package:e_voting/screens/homepage.dart';
import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/screens/profile.dart';
import 'package:e_voting/services/user_data.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/sign_up_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late double height = MediaQuery.of(context).size.height;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController cniccontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController doecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
                InputField(
                  label: 'Name',
                  labelText: 'Enter Your Name',
                  controller: namecontroller,
                ),
                InputField(
                  label: 'CNIC',
                  labelText: '37406-3675252-1',
                  controller: cniccontroller,
                ),
                InputField(
                  label: 'Date of Expiry',
                  labelText: '02/22',
                  controller: doecontroller,
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
                SignupLoginButton(
                  btnText: 'Continue',
                  function: registeruser,
                ),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
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

  Future<void> registeruser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    )
        .then(
      (value) {
        final user = UserData(
          fullName: namecontroller.text,
          cnic: cniccontroller.text,
          doe: doecontroller.text,
          email: emailcontroller.text,
          password: passwordcontroller.text,
          number: "null",
          mName: "null",
          perAddress: "null",
          currAddress: "null",
        );
        UserData.savePassToFirestore(user);

        Fluttertoast.showToast(msg: "Signup Successful");
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CreateProfile(),
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

import 'package:e_voting/screens/homepage.dart';
import 'package:e_voting/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:e_voting/screens/profile.dart';
import 'package:e_voting/widgets/signup_login_button.dart';

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
  final loginformkey = GlobalKey<FormState>();
  final toast = FToast();
  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginformkey,
        child: SingleChildScrollView(
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
                    errormessage: "Please Enter valid email",
                    fieldmessage: "email",
                  ),
                  InputField(
                    label: 'Password',
                    labelText: '***************',
                    controller: passwordcontroller,
                    obscure: true,
                    errormessage: "please enter 8-50 length password",
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
                  SignupLoginButton(
                    btnText: 'Signin',
                    function: loginuser,
                    formkey: loginformkey,
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
                ],
              ),
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
        toast.showToast(
            child: buildtoast("Sign In successful", "success"),
            gravity: ToastGravity.BOTTOM);
        if (!mounted) return;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Homepage(),
            ),
            (route) => false);
      },
    ).onError(
      (error, stackTrace) {
        toast.showToast(
            child: buildtoast("Sign In unsuccessful", "error"),
            gravity: ToastGravity.BOTTOM);
      },
    );
  }
}

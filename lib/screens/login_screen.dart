import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:e_voting/widgets/toast.dart';
import 'package:e_voting/screens/dashboard.dart';
import 'package:e_voting/widgets/password_field.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/screens/signup_screen.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:e_voting/providers/firebase_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _loginformkey = GlobalKey<FormState>();
  final _toast = FToast();

  @override
  void initState() {
    super.initState();
    _toast.init(context);
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
        key: _loginformkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                  // const InputField(
                  //   labeltext: 'Cnic',
                  //   hintText: '33303-1234567-8',
                  //   fieldmessage: FieldMsgs.cnic,
                  //   errormessage: "Please input valid Cnic",
                  // ),
                  InputField(
                    labeltext: 'Email',
                    hintText: 'example@gmail.com',
                    controller: _emailcontroller,
                    errormessage: "Please Enter valid email",
                    fieldmessage: FieldMsgs.email,
                  ),
                  PasswordField(
                    label: 'Password',
                    labelText: '***************',
                    controller: _passwordcontroller,
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
                    isLoading: true,
                    btnText: 'Sign in',
                    function: () async {
                      await _loginUser();
                    },
                    formkey: _loginformkey,
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

  Future<void> _loginUser() async {
    await context.read<FirebaseAuthProvider>().signInwithEmailandPassword(
          _emailcontroller.text,
          _passwordcontroller.text,
        );

    if (!mounted) return;
    final authProvider = context.read<FirebaseAuthProvider>();

    if (authProvider.hasError) {
      _toast.showToast(
        child: buildtoast(authProvider.errorMsg, "error"),
        gravity: ToastGravity.BOTTOM,
      );
      Future.delayed(
        const Duration(seconds: 5),
      );
      _toast.showToast(
        child: buildtoast("Please Signup", "error"),
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ),
      );
      return;
    }

    _toast.showToast(
      child: buildtoast("Sign In successful", "success"),
      gravity: ToastGravity.BOTTOM,
    );

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
    );
  }
}

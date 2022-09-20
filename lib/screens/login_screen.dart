import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:e_voting/providers/firebase_auth_provider.dart';
import 'package:e_voting/widgets/password_field.dart';
import 'package:e_voting/widgets/toast.dart';
import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:e_voting/screens/signup_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';

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
                  const InputField(
                    labeltext: 'Cnic',
                    hintText: '33303-1234567-8',
                    fieldmessage: FieldMsgs.cnic,
                    errormessage: "Please input valid Cnic",
                  ),
                  InputField(
                    labeltext: 'Email',
                    hintText: 'example@gmail.com',
                    controller: emailcontroller,
                    errormessage: "Please Enter valid email",
                    fieldmessage: FieldMsgs.email,
                  ),
                  PasswordField(
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
                    isLoading: true,
                    btnText: 'Sign in',
                    function: () async {
                      await loginUser();
                    },
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

  Future<void> loginUser() async {
    await context.read<FirebaseAuthProvider>().signInwithEmailandPassword(
          emailcontroller.text,
          passwordcontroller.text,
        );
    if (!mounted) return;
    final authProvider = context.read<FirebaseAuthProvider>();
    if (authProvider.hasError) {
      toast.showToast(
        child: buildtoast(authProvider.errorMsg, "error"),
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    toast.showToast(
      child: buildtoast("Sign In successful", "success"),
      gravity: ToastGravity.BOTTOM,
    );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
  }
}

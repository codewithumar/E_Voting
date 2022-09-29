import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/screens/create_profile_screen.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/providers/firebase_auth_provider.dart';
import 'package:e_voting/widgets/password_field.dart';
import 'package:e_voting/widgets/toast.dart';
import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/signup_login_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _cniccontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _doecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _signupformkey = GlobalKey<FormState>();
  final _toast = FToast();

  @override
  void initState() {
    super.initState();
    _toast.init(context);
  }

  @override
  void dispose() {
    _namecontroller.dispose();
    _cniccontroller.dispose();
    _emailcontroller.dispose();
    _doecontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _signupformkey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    labeltext: 'Name',
                    hintText: 'Enter Your Name',
                    controller: _namecontroller,
                    errormessage: "Please enter valid name",
                    fieldmessage: FieldMsgs.name,
                  ),
                  InputField(
                    labeltext: 'CNIC',
                    hintText: '37406-3675252-1',
                    controller: _cniccontroller,
                    errormessage: "Please Enter valid Cnic",
                    fieldmessage: FieldMsgs.cnic,
                  ),
                  InputField(
                    labeltext: 'Date of Expiry',
                    hintText: '- - /- - / - - - -',
                    controller: _doecontroller,
                    errormessage: "Enter valid date",
                    fieldmessage: FieldMsgs.doe,
                    readOnly: true,
                  ),
                  InputField(
                    labeltext: 'Email',
                    hintText: 'example@gmail.com',
                    controller: _emailcontroller,
                    errormessage: "Enter valid email",
                    fieldmessage: FieldMsgs.email,
                  ),
                  PasswordField(
                    label: 'Password',
                    labelText: '*********',
                    controller: _passwordcontroller,
                    obscure: true,
                    errormessage: "Enter valid password 8-50",
                  ),
                  SignupLoginButton(
                    isLoading: context.watch<FirebaseAuthProvider>().isLoading,
                    btnText: 'Continue',
                    function: () async {
                      await _registeruser();
                    },
                    formkey: _signupformkey,
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
      ),
    );
  }

  Future<void> _registeruser() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {});
    await context.read<FirebaseAuthProvider>().signupwithEmailandPassword(
          _emailcontroller.text,
          _passwordcontroller.text,
        );
    if (!mounted) return;
    final signupauthProvider = context.read<FirebaseAuthProvider>();
    if (signupauthProvider.hasError) {
      _toast.showToast(
        child: buildtoast(signupauthProvider.errorMsg, "error"),
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    final docUser = UserData(
      fullName: _namecontroller.text,
      cnic: _cniccontroller.text,
      doe: _doecontroller.text,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      number: 'null',
      mName: 'null',
      perAddress: 'null',
      currAddress: 'null',
      url: 'null',
      role: Role.voter,
    );
    FirestoreService.savePassToFirestore(docUser);
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => CreateProfile(
          _namecontroller.text,
        ),
      ),
      (route) => false,
    );
  }
}

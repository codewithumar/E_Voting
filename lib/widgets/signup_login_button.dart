// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class SignupLoginButton extends StatefulWidget {
  const SignupLoginButton({
    Key? key,
    required this.btnText,
    required this.function,
    this.formkey,
    // required this.onpress,
  }) : super(key: key);
  final String btnText;
  final VoidCallback function;
  final GlobalKey<FormState>? formkey;
  //Function() onpress;

  @override
  State<SignupLoginButton> createState() => _SignupLoginButtonState();
}

class _SignupLoginButtonState extends State<SignupLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          color: Constants.primarycolor,
          textColor: Constants.buttontextcolor,
          onPressed: () {
            if (widget.formkey!.currentState!.validate()) {
              widget.function();
            }
          },
          child: Text(
            widget.btnText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

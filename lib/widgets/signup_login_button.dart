// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class SignupLoginButton extends StatelessWidget {
  const SignupLoginButton({
    Key? key,
    required this.btnText,
    required this.function,
  }) : super(key: key);
  final String btnText;
  final VoidCallback function;

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
          onPressed: () => function(),
          child: Text(
            btnText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

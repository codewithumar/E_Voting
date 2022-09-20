// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/providers/firebase_auth_provider.dart';

class SignupLoginButton extends StatelessWidget {
  const SignupLoginButton({
    Key? key,
    required this.btnText,
    required this.function,
    this.formkey,
    required this.isLoading,
  }) : super(key: key);
  final String btnText;
  final VoidCallback function;
  final GlobalKey<FormState>? formkey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
          onPressed: context.watch<FirebaseAuthProvider>().isLoading
              ? null
              : () {
                  if (formkey!.currentState!.validate()) {
                    function();
                  }
                },
          child: context.watch<FirebaseAuthProvider>().isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Text(
                  btnText,
                  style: const TextStyle(fontSize: 16),
                ),
        ),
      ),
    );
  }
}

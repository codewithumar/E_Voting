import 'package:e_voting/utils/constants.dart';
import 'package:flutter/material.dart';

class SignupLoginButton extends StatelessWidget {
  const SignupLoginButton({
    Key? key,
    required this.btnText,
  }) : super(key: key);
  final String btnText;
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
          onPressed: () {},
          child: Text(
            btnText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

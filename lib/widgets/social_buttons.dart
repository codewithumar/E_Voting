import 'package:e_voting/utils/constants.dart';
import 'package:flutter/material.dart';

Widget buildFacebookLogin() {
  return Container(
    width: 81.08,
    height: 50,
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
    width: 81.08,
    height: 50,
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

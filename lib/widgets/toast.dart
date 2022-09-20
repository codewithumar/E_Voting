import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

Widget buildtoast(String message, String iconname) => Container(
      height: 52,
      width: 380,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xff151619),
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage("assets/images/icons/$iconname.png"),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            message,
            style: const TextStyle(color: Constants.textcolor),
          ),
        ],
      ),
    );

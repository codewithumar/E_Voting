// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({
    Key? key,
    required this.btnText,
    required this.function,
  }) : super(key: key);
  final String btnText;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 33.33,
      minWidth: 122,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Constants.primarycolor,
      textColor: Constants.buttontextcolor,
      onPressed: function,
      child: Text(
        btnText,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

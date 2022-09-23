import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Constants.greensnackbarColor,
    );
  }
}

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class VoterScreen extends StatelessWidget {
  const VoterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? AppBar(
              centerTitle: true,
              title: const Text("Elections"),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Constants.colors,
                  ),
                ),
              ),
            )
          : null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Voter Screen"),
          ],
        ),
      ),
    );
  }
}

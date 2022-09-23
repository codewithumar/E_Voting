import 'package:e_voting/screens/Edit_party-screen.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class PartiesTiles extends StatelessWidget {
  const PartiesTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
              blurStyle: BlurStyle.solid,
            ),
          ],
          color: Constants.adminScreenButtonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height * .07
            : (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height * .07
                : null,
        width: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.width * .9
            : (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.width * .9
                : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/partiesimage/pmln.png"),
              height: 80,
              width: 80,
            ),
            const Text(
              "Pakistan Muslim League N",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditPartyScren(),
                  ),
                );
              },
              child: const Icon(
                Icons.more_vert,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}

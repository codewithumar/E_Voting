import 'package:e_voting/screens/edit_party-screen.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/utils/constants.dart';

class PartiesTiles extends StatelessWidget {
  const PartiesTiles({required this.patryname, required this.index, super.key});
  final String patryname;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
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
              height: 40,
              width: 40,
            ),
            Text(
              patryname,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            PopupMenuButton(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  height: 26.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EditPartyScren(),
                          ),
                        );
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  height: 26.5,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const EditPartyScren(),
                          ),
                        );
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

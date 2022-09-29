import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting/screens/edit_party-screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PartiesTiles extends StatelessWidget {
  const PartiesTiles(
      {required this.patryname,
      required this.url,
      required this.index,
      super.key});
  final String? patryname;
  final int index;
  final String url;
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
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Constants.adminScreenButtonColor,
                foregroundColor: Constants.textcolor,
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                  url,
                ),
              ),
            ),
            Text(
              patryname ?? "",
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
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PopMenuOption>>[
                PopupMenuItem<PopMenuOption>(
                  value: PopMenuOption.edit,
                  padding: const EdgeInsets.all(10),
                  onTap: () async {
                    Fluttertoast.showToast(msg: "Edit");
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const EditPartyScren(),
                      ),
                    );
                  },
                  height: 26.5,
                  child: const Center(
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: Constants.popupmenutextcolor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  padding: const EdgeInsets.all(10),
                  onTap: () {
                    Fluttertoast.showToast(msg: "Delete");
                  },
                  height: 26.5,
                  child: const Center(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        color: Constants.popupmenutextcolor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

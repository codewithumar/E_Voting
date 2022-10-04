import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/services/firebase%20_storage_service.dart';
import 'package:e_voting/screens/edit_party-screen.dart';
import 'package:e_voting/utils/constants.dart';

class PartiesTiles extends StatelessWidget {
  const PartiesTiles({required this.data, super.key});
  final PartyModel data;

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
                  data.imgURl,
                ),
              ),
            ),
            Text(
              data.partyname,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            PopupMenuButton<PopMenuOption>(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              onSelected: (value) async {
                if (value == PopMenuOption.edit) {
                  log(data.id!);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditPartyScren(
                        data: data,
                      ),
                    ),
                  );
                }
                if (value == PopMenuOption.delete) {
                  await FirebaseStorageService.deleteParty(data.id!);
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<PopMenuOption>>[
                const PopupMenuItem<PopMenuOption>(
                  value: PopMenuOption.edit,
                  height: 26.5,
                  child: Center(
                    child: Text(
                      "Edit",
                      style: TextStyle(
                        color: Constants.popupmenutextcolor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const PopupMenuItem<PopMenuOption>(
                  padding: EdgeInsets.all(10),
                  height: 26.5,
                  value: PopMenuOption.delete,
                  child: Center(
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

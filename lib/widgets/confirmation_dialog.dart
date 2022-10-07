import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/alertdialogbutton.dart';

import 'package:flutter/material.dart';

Future<void> showAlertDialog(
        BuildContext context, PartyModel data, final VoidCallback function) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Constants.alertdialoagcolor,
        title: Padding(
          padding: const EdgeInsets.all(50),
          child: CircleAvatar(
            radius: 50,
            child: Image(
              image: CachedNetworkImageProvider(
                data.imgURl,
              ),
            ),
          ),
        ),
        content: Text(
          "Are you sure you want to vote for ${data.partyname}?",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AlertDialogButton(
                  btnText: "Cancel",
                  function: () async {
                    Navigator.of(context).pop();
                  },
                ),
                AlertDialogButton(
                  btnText: "Confirm",
                  function: () {
                    function();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

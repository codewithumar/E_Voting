import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/providers/firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/models/votecountmodel.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/widgets/confirmation_dialog.dart';
import 'package:provider/provider.dart';

class VotingTiles extends StatefulWidget {
  const VotingTiles({
    required this.partydata,
    required this.electiondata,
    super.key,
  });
  final PartyModel partydata;
  final ElectionModel electiondata;

  @override
  State<VotingTiles> createState() => _VotingTilesState();
}

class _VotingTilesState extends State<VotingTiles> {
  @override
  void initState() {
    super.initState();
  }

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
        height: 150,
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 17, 16, 0),
              child: CircleAvatar(
                backgroundColor: Constants.adminScreenButtonColor,
                foregroundColor: Constants.textcolor,
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(
                  widget.partydata.imgURl,
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 15, 15),
              child: Column(
                children: [
                  Text(
                    widget.partydata.partyname,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  MaterialButton(
                    height: 33.33,
                    minWidth: 122,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Constants.primarycolor,
                    textColor: Constants.buttontextcolor,
                    onPressed: context
                                .read<FirestoreProvider>()
                                .checkvoted
                                .toString() !=
                            widget.electiondata.id.toString()
                        ? () => showAlertDialog(
                              context,
                              widget.partydata,
                              () async {
                                final votedata = VoteCountModel(
                                  partyid: widget.partydata.id!,
                                  partyname: widget.partydata.partyname,
                                  datetime: DateTime.now(),
                                );
                                await FirestoreService.submitVote(
                                  widget.partydata,
                                  votedata,
                                  widget.electiondata,
                                );
                              },
                            )
                        : null,
                    child: const Text(
                      "Vote",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

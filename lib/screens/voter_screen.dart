import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class VoterScreen extends StatelessWidget {
  const VoterScreen({required this.data, super.key});
  final UserData data;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 17, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi ${data.fullName.toUpperCase()}!",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Constants.primarycolor),
                    ),
                    const Text(
                      "Be a part of the decision vote today",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Constants.popupmenutextcolor),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 16, 0),
                child: CircleAvatar(
                  backgroundColor: Constants.adminScreenButtonColor,
                  foregroundColor: Constants.textcolor,
                  radius: 25,
                  backgroundImage: CachedNetworkImageProvider(
                    data.url,
                  ),
                ),
              ),
            ],
          ),
          //const Expanded(child: SizedBox()),
          const Image(
            image: AssetImage(
              "assets/images/Manworking.png",
            ),
          ),
          const Text(
            "Seems no elections going on!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Constants.popupmenutextcolor),
          )
        ],
      ),
    );
  }
}

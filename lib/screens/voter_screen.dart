import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:e_voting/providers/firestore_provider.dart';

import 'package:e_voting/widgets/voterelectiontiles.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
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
                      Constants.electionstring,
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: StreamBuilder(
                stream: context.read<FirestoreProvider>().getElections(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      children: const [
                        Image(
                          image: AssetImage(
                            "assets/images/Manworking.png",
                          ),
                        ),
                        Text(
                          Constants.noelectionstring2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Constants.popupmenutextcolor),
                        ),
                      ],
                    );
                  }

                  if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return VoterElectionTiles(
                            data: data[index],
                          );
                        },
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: const [
                      Image(
                        image: AssetImage(
                          "assets/images/Manworking.png",
                        ),
                      ),
                      Text(
                        "Seems no elections going on!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Constants.popupmenutextcolor),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

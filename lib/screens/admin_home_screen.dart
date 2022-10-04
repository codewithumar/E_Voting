import 'package:e_voting/providers/firestore_provider.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/adminelectiontiles.dart';

import 'package:e_voting/widgets/adminscreenbutton.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? AppBar(
              centerTitle: true,
              title: const Text("Home"),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Constants.colors,
                  ),
                ),
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdminScreenButton(
                    "parties",
                    "Parties",
                    type: AdminButton.party,
                  ),
                  AdminScreenButton(
                    "election",
                    "Create Election",
                    type: AdminButton.election,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              StreamBuilder(
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
                          return AdminElectionTiles(
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
                  return const Center(
                    child: Text("No Data"),
                  );
                },
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

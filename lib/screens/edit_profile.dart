// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/screens/homepage.dart';
import 'package:e_voting/services/user_data.dart';
import 'package:e_voting/widgets/sign_up_fields.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Constants.primarycolor,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Constants.primarycolor,
            height: 1.0,
          ),
        ),
      ),
      body: StreamBuilder<List<UserData>>(
        stream: UserData.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.data}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Waiting');
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return EditProfileStream(users, context);
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Text("Working to get data");
        },
      ),
    );
  }
}

class EditProfileStream extends StatelessWidget {
  EditProfileStream(
    this.users,
    this.context, {
    Key? key,
  }) : super(key: key);
  final List<UserData> users;
  BuildContext context;

  late TextEditingController numberController =
      TextEditingController(text: users[0].number);
  late TextEditingController curAddressController =
      TextEditingController(text: users[0].currAddress);
  late TextEditingController doeController =
      TextEditingController(text: users[0].doe);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constants.greyColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_photo_alternate_rounded,
                        color: Constants.primarycolor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    users[0].fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff027314),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    users[0].email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Constants.greyColor,
                    ),
                  ),
                ),
              ),
              InputField(
                label: 'Date of Expiry',
                labelText: users[0].doe,
                controller: doeController,
              ),
              InputField(
                label: 'Phone Number',
                labelText: users[0].number,
                controller: numberController,
              ),
              InputField(
                label: 'Current Address',
                labelText: users[0].currAddress,
                controller: curAddressController,
              ),
              SignupLoginButton(btnText: 'Update', function: updateProfile),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(users[0].id);
    log(FirebaseAuth.instance.currentUser!.email!);
    log('${doeController.text}, ${numberController.text}');

    docUser.update(
      {
        "DoE": doeController.text,
        "number": numberController.text,
        "currAddress": curAddressController.text,
      },
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ),
        (route) => false);
  }
}

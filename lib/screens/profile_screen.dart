import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_voting/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:file_picker/file_picker.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: Constants.colors,
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () async {
                  await context.read<FirebaseAuthProvider>().signOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    showsnackbar(
                      Colors.black,
                      "Sign out Successful",
                      context,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                ),
              ),
              title: const Text(
                'Profile',
              ),
              centerTitle: true,
              actions: <Widget>[
                MaterialButton(
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  },
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                  child: const Text(
                    "Edit",
                  ),
                ),
              ],
            )
          : null,
      body: StreamBuilder<UserData>(
        stream: FirestoreService.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(' ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ProfileStream(snapshot.requireData);
        },
      ),
    );
  }
}

class ProfileStream extends StatefulWidget {
  const ProfileStream(
    this.users, {
    Key? key,
  }) : super(key: key);
  final UserData users;

  @override
  State<ProfileStream> createState() => ProfileStreamState();
}

class ProfileStreamState extends State<ProfileStream> {
  late final idURL = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .doc(widget.users.id)
      .toString();
  PlatformFile? pickedFile;
  UploadTask? upload;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(imageUrl: widget.users.url),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Container(
              //       height: 70,
              //       width: 70,
              //       foregroundDecoration: (widget.users.url != 'null')
              //           ? BoxDecoration(
              //               image: DecorationImage(
              //                 image:
              //                     CachedNetworkImageProvider(widget.users.url),
              //                 fit: BoxFit.fill,
              //                 scale: 0.5,
              //               ),
              //             )
              //           : null,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Constants.greyColor,
              //         ),
              //         borderRadius: const BorderRadius.all(
              //           Radius.circular(10),
              //         ),
              //       ),
              //       child: IconButton(
              //         icon: (widget.users.url == 'null')
              //             ? const Icon(
              //                 Icons.add_photo_alternate_rounded,
              //                 color: Constants.primarycolor,
              //               )
              //             : Image.asset(widget.users.url),
              //         iconSize: 50,
              //         onPressed: () {},
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.users.fullName,
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
                    widget.users.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Constants.greyColor,
                    ),
                  ),
                ),
              ),
              InputField(
                labeltext: 'Full Name',
                hintText: widget.users.fullName,
                readOnly: true,
              ),
              InputField(
                labeltext: 'Email',
                hintText: widget.users.email,
                readOnly: true,
              ),
              InputField(
                labeltext: 'CNIC',
                hintText: widget.users.cnic,
                readOnly: true,
              ),
              InputField(
                labeltext: 'Date of Expiry',
                hintText: widget.users.doe,
                readOnly: true,
              ),
              InputField(
                labeltext: 'Phone Number',
                hintText: widget.users.number,
                readOnly: true,
              ),
              InputField(
                labeltext: "Mother's Name",
                hintText: widget.users.mName,
                readOnly: true,
              ),
              InputField(
                labeltext: 'Permanent Address',
                hintText: widget.users.perAddress,
                readOnly: true,
              ),
              InputField(
                labeltext: 'Current Address',
                hintText: widget.users.currAddress,
                readOnly: true,
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

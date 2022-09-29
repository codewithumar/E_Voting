// ignore_for_file: must_be_immutable
import 'dart:developer';
import 'dart:io';
import 'package:e_voting/services/firebase%20_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:e_voting/screens/dashboard.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:e_voting/services/firestore_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.colors,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<UserData>(
        stream: FirestoreService.readUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Waiting....'));
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return EditProfileStream(users, context);
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
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
  final UserData users;
  BuildContext context;

  File? _file;
  late TextEditingController numberController =
      TextEditingController(text: users.number);
  late TextEditingController curAddressController =
      TextEditingController(text: users.currAddress);
  late TextEditingController doeController =
      TextEditingController(text: users.doe);
  @override
  Widget build(BuildContext context) {
    final editprofileformkey = GlobalKey<FormState>();

    return Form(
      key: editprofileformkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    foregroundDecoration: (users.url != 'null')
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(users.url),
                              fit: BoxFit.fill,
                            ),
                          )
                        : null,
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
                      onPressed: () {
                        FirebaseStorageService.selectFile(
                            users.id, "profileimages", false);
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    users.fullName,
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
                    users.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Constants.greyColor,
                    ),
                  ),
                ),
              ),
              InputField(
                labeltext: 'Date of Expiry',
                hintText: users.doe,
                controller: doeController,
                readOnly: true,
                errormessage: "Please Select a corrrect Date",
                fieldmessage: FieldMsgs.doe,
              ),
              InputField(
                labeltext: 'Phone Number',
                hintText: users.number,
                controller: numberController,
                errormessage: "Please Enter phone number",
                fieldmessage: FieldMsgs.phone,
              ),
              InputField(
                labeltext: 'Current Address',
                hintText: users.currAddress,
                controller: curAddressController,
                errormessage: "Please enter correct address",
              ),
              SignupLoginButton(
                isLoading: false,
                btnText: 'Update',
                function: updateProfile,
                formkey: editprofileformkey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(users.id);
    log(FirebaseAuth.instance.currentUser!.email!);
    log('${doeController.text}, ${numberController.text}');

    docUser.update(
      {
        "DoE": doeController.text,
        "number": numberController.text,
        "currAddress": curAddressController.text,
      },
    ).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          showsnackbar(
            Constants.greensnackbarColor,
            "Changes Applied Successfully",
            context,
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
            (route) => false);
      },
    ).onError(
      (error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          showsnackbar(
            Constants.redsnackbarColor,
            "Entry Unsuccessful",
            context,
          ),
        );
      },
    );
  }

  Future selectFile(String docID) async {
    String? urlDownload;
    final id = FirebaseFirestore.instance
        .collection(
          FirebaseAuth.instance.currentUser!.email!,
        )
        .doc(docID);
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    PlatformFile? pickedFile;

    if (result != null) {
      pickedFile = result.files.first;
      _file = File(pickedFile.path!);
    }

    final path = '/profileimages/$id/${pickedFile?.name}';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(_file!);
    final upload = ref.putFile(_file!);
    final snapshot = await upload.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    log('url is = $urlDownload');

    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(docID);

    docUser.update(
      {
        "dpURL": urlDownload,
      },
    );
  }
}

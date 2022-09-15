// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/screens/profile_screen.dart';

import 'package:e_voting/services/user_data.dart';
import 'package:e_voting/services/user_simple_preferences.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<UserData>>(
        stream: UserData.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.data}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return CreateProfileStream(context, users);
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

class CreateProfileStream extends StatelessWidget {
  CreateProfileStream(
    this.context,
    this.users, {
    Key? key,
  }) : super(key: key);
  BuildContext context;
  List<UserData> users;

  late double height = MediaQuery.of(context).size.height;
  late TextEditingController phonecontroller =
      TextEditingController(text: users[0].number);
  late TextEditingController mothernamecontroller =
      TextEditingController(text: users[0].mName);
  late TextEditingController currentaddresscontroller =
      TextEditingController(text: users[0].currAddress);
  late TextEditingController permanentaddresscontroller =
      TextEditingController(text: users[0].perAddress);
  final createprofileformkey = GlobalKey<FormState>();
  FilePickerResult? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: createprofileformkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile Creation",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Constants.primarycolor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 58,
                      width: 58,
                      foregroundDecoration: null,
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
                          _selectFile();
                        },
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Name Here",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff027314),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "youremail@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Constants.greyColor,
                      ),
                    ),
                  ),
                ),
                InputField(
                  label: 'Phone Number',
                  labelText: '0900-78601',
                  controller: phonecontroller,
                ),
                InputField(
                  label: "Mother's Name",
                  labelText: "Alexa",
                  controller: mothernamecontroller,
                ),
                InputField(
                  label: 'Permanent Adress',
                  labelText: 'Rab Nawaz Colony',
                  controller: permanentaddresscontroller,
                ),
                InputField(
                  label: 'Current Address',
                  labelText: 'Mullah Ki Basti',
                  controller: currentaddresscontroller,
                ),
                SignupLoginButton(
                  isLoading: false,
                  btnText: 'Create Profile',
                  function: createProfile,
                  formkey: createprofileformkey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createProfile() async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(users[0].id);
    docUser.update(
      {
        "motherName": mothernamecontroller.text,
        "number": phonecontroller.text,
        "currAddress": currentaddresscontroller.text,
        "perAddress": permanentaddresscontroller.text,
      },
    ).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        showsnackbar(
          Constants.greensnackbarColor,
          "Changes Applied Successfully",
          context,
        ),
      );
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        showsnackbar(
          Constants.redsnackbarColor,
          "Could Not Apply Changes",
          context,
        ),
      );
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
        (route) => false);
  }

  Future _selectFile() async {
    File? file;
    final id = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(users[0].id);
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    PlatformFile? pickedFile;
    if (result != null) {
      pickedFile = result.files.first;
      file = File(pickedFile.path!);
    }
    final path = '/profileimages/$id/${pickedFile?.name}';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file!);
    final upload = ref.putFile(file);
    final snapshot = await upload.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    UserSimplePreferences.storeURL(id.toString(), urlDownload!);
  }
}

// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/screens/signup_screen.dart';

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

class CreateProfileStream extends StatefulWidget {
  CreateProfileStream(
    this.context,
    this.users, {
    Key? key,
  }) : super(key: key);
  BuildContext context;
  List<UserData> users;

  @override
  State<CreateProfileStream> createState() => _CreateProfileStreamState();
}

class _CreateProfileStreamState extends State<CreateProfileStream> {
  late double height = MediaQuery.of(widget.context).size.height;

  late TextEditingController phonecontroller = TextEditingController();

  late TextEditingController mothernamecontroller = TextEditingController();

  late TextEditingController currentaddresscontroller = TextEditingController();

  late TextEditingController permanentaddresscontroller =
      TextEditingController();

  final createprofileformkey = GlobalKey<FormState>();

  FilePickerResult? pickedFile;

  bool checkBoxValue = false;

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
                      foregroundDecoration: (widget.users[0].url != 'null')
                          ? BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.users[0].url),
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
                          setState(() {
                            selectFile(widget.users[0].id);
                          });
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
                  labeltext: 'Phone Number',
                  hintText: '0900-78601',
                  controller: phonecontroller,
                ),
                InputField(
                  labeltext: "Mother's Name",
                  hintText: "Alexa",
                  controller: mothernamecontroller,
                ),
                InputField(
                  labeltext: 'Permanent Adress',
                  hintText: 'Address',
                  controller: permanentaddresscontroller,
                  fieldmessage: FieldMsg.address,
                ),
                InputField(
                  labeltext: 'Current Address',
                  hintText: 'Address',
                  controller: currentaddresscontroller,
                  fieldmessage: FieldMsg.address,
                ),
                SizedBox(
                  child: CheckboxListTile(
                    title: const Text(
                      'Same as Permanent Address',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Constants.greyColor,
                      ),
                    ),
                    checkColor: Colors.white,
                    selectedTileColor: Constants.lightGreen,
                    activeColor: Constants.lightGreen,
                    value: checkBoxValue,
                    onChanged: (newValue) {
                      setState(() {
                        log(checkBoxValue.toString());
                        checkBoxValue = newValue!;
                        if (checkBoxValue == true) {
                          permanentaddresscontroller = currentaddresscontroller;
                        } else {
                          currentaddresscontroller = TextEditingController(
                              text: currentaddresscontroller.text);
                          permanentaddresscontroller = TextEditingController(
                              text: permanentaddresscontroller.text);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
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
        .doc(widget.users[0].id);
    docUser.update(
      {
        "motherName": mothernamecontroller.text,
        "number": phonecontroller.text,
        "currAddress": currentaddresscontroller.text,
        "perAddress": permanentaddresscontroller.text,
      },
    ).then((value) {
      ScaffoldMessenger.of(widget.context).showSnackBar(
        showsnackbar(
          Constants.greensnackbarColor,
          "Changes Applied Successfully",
          widget.context,
        ),
      );
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(widget.context).showSnackBar(
        showsnackbar(
          Constants.redsnackbarColor,
          "Could Not Apply Changes",
          widget.context,
        ),
      );
    });
    Navigator.of(widget.context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Profile(),
        ),
        (route) => false);
  }
}

Future selectFile(String docID) async {
  File? file;
  String? urlDownload;
  final id = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .doc(docID);
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

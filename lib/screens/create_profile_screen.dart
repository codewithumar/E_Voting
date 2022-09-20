// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/screens/profile_screen.dart';
import 'package:e_voting/screens/signup_screen.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/widgets/signup_login_button.dart';

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
        stream: FirestoreServices.readUsers(),
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
              return CreateProfileStream(users);
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
    this.users, {
    Key? key,
  }) : super(key: key);

  List<UserData> users;

  @override
  State<CreateProfileStream> createState() => _CreateProfileStreamState();
}

class _CreateProfileStreamState extends State<CreateProfileStream> {
  late double height = MediaQuery.of(context).size.height;
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _mothernamecontroller = TextEditingController();
  TextEditingController _currentaddresscontroller = TextEditingController();
  TextEditingController _permanentaddresscontroller = TextEditingController();
  //! ALERT: Late keyword used badly. No use of late keyword here
  final _createprofileformkey = GlobalKey<FormState>();
  bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createprofileformkey,
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
                  controller: _phonecontroller,
                ),
                InputField(
                  labeltext: "Mother's Name",
                  hintText: "Alexa",
                  controller: _mothernamecontroller,
                ),
                InputField(
                  labeltext: 'Permanent Adress',
                  hintText: 'Address',
                  controller: _permanentaddresscontroller,
                  fieldmessage: FieldMsgs.address,
                ),
                InputField(
                  labeltext: 'Current Address',
                  hintText: 'Address',
                  controller: _currentaddresscontroller,
                  fieldmessage: FieldMsgs.address,
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
                    value: _checkBoxValue,
                    onChanged: (newValue) {
                      setState(
                        () {
                          log(_checkBoxValue.toString());
                          _checkBoxValue = newValue!;
                          if (_checkBoxValue == true) {
                            _permanentaddresscontroller =
                                _currentaddresscontroller;
                          } else {
                            _currentaddresscontroller = TextEditingController(
                                text: _currentaddresscontroller.text);
                            _permanentaddresscontroller = TextEditingController(
                                text: _permanentaddresscontroller.text);
                          }
                        },
                      );
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                SignupLoginButton(
                  isLoading: false,
                  btnText: 'Create Profile',
                  function: _createProfile,
                  formkey: _createprofileformkey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createProfile() async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(widget.users[0].id);
    docUser.update(
      {
        "motherName": _mothernamecontroller.text,
        "number": _phonecontroller.text,
        "currAddress": _currentaddresscontroller.text,
        "perAddress": _permanentaddresscontroller.text,
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

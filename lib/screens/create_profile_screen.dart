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
import 'package:e_voting/screens/dashboard.dart';
import 'package:e_voting/models/user_data.dart';

import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/widgets/signup_login_button.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile(this._name, {super.key});
  final String _name;

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<UserData>(
        stream: FirestoreService.readUsers(),
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
              return CreateProfileStream(
                users,
                widget._name,
              );
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
    this.users,
    this._name, {
    Key? key,
  }) : super(key: key);
  final String _name;

  UserData users;

  @override
  State<CreateProfileStream> createState() => _CreateProfileStreamState();
}

class _CreateProfileStreamState extends State<CreateProfileStream> {
  File? _file;
  bool _checkBoxValue = false;
  final _createprofileformkey = GlobalKey<FormState>();

  final TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _currentaddresscontroller = TextEditingController();
  final TextEditingController _mothernamecontroller = TextEditingController();
  TextEditingController _permanentaddresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 58,
                      width: 58,
                      foregroundDecoration: _file != null
                          ? BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(_file!),
                                fit: BoxFit.fill,
                              ),
                            )
                          : null,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Constants.greyColor,
                        ),
                        image: _file != null
                            ? DecorationImage(
                                image: FileImage(_file!),
                                fit: BoxFit.fill,
                              )
                            : null,
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
                          _selectFile(widget.users.id);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget._name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff027314),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 3, 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Constants.greyColor,
                      ),
                    ),
                  ),
                ),
                InputField(
                  labeltext: 'Phone Number',
                  hintText: '92333-1234567',
                  controller: _phonecontroller,
                  fieldmessage: FieldMsgs.phone,
                  errormessage: "Please Enter phone number",
                ),
                InputField(
                  labeltext: "Mother's Name",
                  hintText: "Alexa",
                  controller: _mothernamecontroller,
                  fieldmessage: FieldMsgs.name,
                  errormessage: "Please enter correct Mother name min 4 words",
                ),
                InputField(
                  labeltext: 'Current Address',
                  hintText: 'Address',
                  controller: _currentaddresscontroller,
                  fieldmessage: FieldMsgs.address,
                  errormessage: "Please enter correct address 10 alphabets min",
                ),
                InputField(
                  labeltext: 'Permanent Adress',
                  hintText: 'Address',
                  controller: _permanentaddresscontroller,
                  fieldmessage: FieldMsgs.address,
                  errormessage: "Please enter correct address 10 alphabets min",
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _checkBoxValue,
                      checkColor: Constants.textcolor,
                      onChanged: (newValue) {
                        _checkBoxValue = newValue!;
                        setState(
                          () {
                            log(" in setstate ${_checkBoxValue.toString()}");
                            if (_checkBoxValue == true) {
                              _permanentaddresscontroller =
                                  _currentaddresscontroller;
                            } else {
                              _currentaddresscontroller = TextEditingController(
                                  text: _currentaddresscontroller.text);
                              _permanentaddresscontroller =
                                  TextEditingController(
                                      text: _permanentaddresscontroller.text);
                            }
                          },
                        );
                      },
                    ),
                    const Text("Same as Permanent Address")
                  ],
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
        .doc(FirebaseAuth.instance.currentUser!.uid);
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
          builder: (context) => const Dashboard(),
        ),
        (route) => false);
  }

  Future _selectFile(String docID) async {
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
      setState(() {
        pickedFile = result.files.first;
        log(pickedFile.toString());
        _file = File(pickedFile!.path!);
        log(_file.toString());
      });
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

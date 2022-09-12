import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/screens/create_profile.dart';
import 'package:e_voting/screens/edit_profile.dart';
import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/services/user_data.dart';
import 'package:e_voting/widgets/sign_up_fields.dart';
import 'package:e_voting/widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async => {
            await FirebaseAuth.instance.signOut(),
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false),
            ScaffoldMessenger.of(context).showSnackBar(
              showsnackbar(
                Colors.black,
                "Sign out Successful",
                context,
              ),
            )
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Constants.primarycolor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
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
            shape:
                const CircleBorder(side: BorderSide(color: Colors.transparent)),
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
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
            return Center(child: Text('${snapshot.data}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final users = snapshot.data!;
              return ProfileStream(users);
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

class ProfileStream extends StatelessWidget {
  ProfileStream(
    this.users, {
    Key? key,
  }) : super(key: key);
  final List<UserData> users;
  FilePickerResult? pickedFile;
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
                      onPressed: () {
                        _selectFile();
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
                label: 'Full Name',
                labelText: users[0].fullName,
                readOnly: true,
              ),
              InputField(
                label: 'Email',
                labelText: users[0].email,
                readOnly: true,
              ),
              InputField(
                label: 'CNIC',
                labelText: users[0].cnic,
                readOnly: true,
              ),
              InputField(
                label: 'Date of Expiry',
                labelText: users[0].doe,
                readOnly: true,
              ),
              InputField(
                label: 'Phone Number',
                labelText: users[0].number,
                readOnly: true,
              ),
              InputField(
                label: 'Full Name',
                labelText: users[0].fullName,
                readOnly: true,
              ),
              InputField(
                label: "Mother's Name",
                labelText: users[0].mName,
                readOnly: true,
              ),
              InputField(
                label: 'Permanent Address',
                labelText: users[0].perAddress,
                readOnly: true,
              ),
              InputField(
                label: 'Current Address',
                labelText: users[0].currAddress,
                readOnly: true,
              ),
              InputField(
                label: 'Password',
                labelText: users[0].password,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _selectFile() async {
    File? _file;
    PlatformFile? _platformFile;
    final id = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc(users[0].id);

    pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (pickedFile != null) {
      // setState(() {
      _file = File(pickedFile!.files.single.path!);
      _platformFile = pickedFile!.files.first;
      // print("Size: ");
      // print(_platformFile?.size);
      // });
    }
    final path = '/profileimages/$id/${pickedFile!.files.first.name}';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(_file!);

    // loadingController.forward();
  }
}

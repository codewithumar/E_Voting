import 'dart:developer';
import 'dart:io';
import 'package:e_voting/models/user_data.dart';
import 'package:e_voting/providers/firestore_provider.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_voting/services/firebase%20_storage_service.dart';
import 'package:e_voting/widgets/toast.dart';

import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:provider/provider.dart';

class CreatePartyScreen extends StatefulWidget {
  const CreatePartyScreen({super.key});

  @override
  State<CreatePartyScreen> createState() => _CreatePartyScreenState();
}

final _partynamecontroller = TextEditingController();
final listpartiesname = [];
final _toast = FToast();

class _CreatePartyScreenState extends State<CreatePartyScreen> {
  @override
  void initState() {
    super.initState();
    _toast.init(context);
    checkexistingpartieslist();
  }

  @override
  void dispose() {
    super.dispose();
    listpartiesname.clear();
  }

  @override
  Widget build(BuildContext context) {
    UserData? d;
    final user = context.read<FirestoreProvider>().readUsers();
    user!.map((event) => d = event);
    final createpartyformkey = GlobalKey<FormState>();
    File? file;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Party",
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.colors,
            ),
          ),
        ),
      ),
      body: Form(
        key: createpartyformkey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 58,
                    width: 58,
                    foregroundDecoration: (file != null)
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(d!.url),
                              fit: BoxFit.fill,
                            ),
                          )
                        : null,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Constants.greyColor,
                      ),
                      image: FirebaseStorageService.file != null
                          ? DecorationImage(
                              image: FileImage(FirebaseStorageService.file!),
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
                      onPressed: () async {
                        if (_partynamecontroller.text == "") {
                          Fluttertoast.showToast(
                              msg: "Please Enter Party Name Fitrst");
                          return;
                        } else {
                          await FirebaseStorageService.selectFile();
                          setState(() {});
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 59),
              InputField(
                labeltext: 'Party Name  ',
                hintText: "Example",
                controller: _partynamecontroller,
                errormessage: "Enter correct name",
              ),
              const SizedBox(height: 23),
              SignupLoginButton(
                isLoading: false,
                btnText: 'Add',
                formkey: createpartyformkey,
                function: () async {
                  await cerateparty();
                  _partynamecontroller.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cerateparty() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (listpartiesname.contains(_partynamecontroller.text.toUpperCase())) {
      _toast.showToast(
        child: buildtoast(
          "Party Already Exists",
          "error",
        ),
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    String id = FirebaseFirestore.instance.collection("Parties").doc().id;
    final party = PartyModel(
      id: id,
      partyname: _partynamecontroller.text.toUpperCase(),
      imgURl: "",
    );

    await FirestoreService.createparty(party);
    _toast.showToast(
      child: buildtoast(
        "Uploading",
        "success",
      ),
      gravity: ToastGravity.BOTTOM,
    );

    await FirebaseStorageService.uploadimage("partyImage", id, true);
    _toast.showToast(
      child: buildtoast("Party Created Success", "success"),
      gravity: ToastGravity.BOTTOM,
    );
    FirebaseStorageService.file = null;
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> checkexistingpartieslist() async {
    await FirebaseFirestore.instance.collection('Parties').get().then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          listpartiesname.add(doc['partyname']);
        }
      },
    );

    log(listpartiesname.toString());
  }
}

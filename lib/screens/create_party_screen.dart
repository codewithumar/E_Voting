import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_voting/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/services/firestore_service.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    final createpartyformkey = GlobalKey<FormState>();

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
                  alignment: Alignment.center,
                  child: Container(
                    height: 70,
                    width: 70,
                    // foregroundDecoration: (users[0].url != 'null')
                    //     ? BoxDecoration(
                    //         image: DecorationImage(
                    //           image: NetworkImage(users[0].url),
                    //           fit: BoxFit.fill,
                    //         ),
                    //       )
                    //     : null,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cerateparty() async {
    if (listpartiesname.contains(_partynamecontroller.text.toUpperCase())) {
      _toast.showToast(
        child: buildtoast("Party Already Exists", "error"),
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }
    final party = PartyModel(
      partyname: _partynamecontroller.text.toUpperCase(),
      imgURl: "",
    );
    FirestoreService.createparty(party);
    _toast.showToast(
      child: buildtoast("Party Created Success", "success"),
      gravity: ToastGravity.BOTTOM,
    );
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

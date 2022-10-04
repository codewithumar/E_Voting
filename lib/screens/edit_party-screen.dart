// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_voting/models/party_model.dart';
import 'package:e_voting/services/firebase%20_storage_service.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';

class EditPartyScren extends StatefulWidget {
  const EditPartyScren({required this.data, super.key});
  final PartyModel data;

  @override
  State<EditPartyScren> createState() => _EditPartyScrenState();
}

class _EditPartyScrenState extends State<EditPartyScren> {
  final updatepartycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final updatepartyformkey = GlobalKey<FormState>();
    return Form(
      key: updatepartyformkey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Party"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: Constants.colors,
              ),
            ),
          ),
        ),
        body: Padding(
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
                    foregroundDecoration: (widget.data.imgURl != "")
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.data.imgURl),
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
                      onPressed: () async {
                        await FirebaseStorageService.selectFile();
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 59),
              InputField(
                hintText: widget.data.partyname,
                labeltext: 'Party Name  ',
                controller: updatepartycontroller,
                errormessage: "Please enter valid party name",
              ),
              const SizedBox(height: 23),
              SignupLoginButton(
                isLoading: false,
                formkey: updatepartyformkey,
                btnText: 'Update',
                function: () async {
                  await updateparty(widget.data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateparty(PartyModel data) async {
    final docRef =
        FirebaseFirestore.instance.collection("Parties").doc(data.id);

    await docRef.update(
      {
        'partyname': updatepartycontroller.text,
      },
    );
    await FirebaseStorageService.uploadimage("partyImage", data.id!, true);
    if (!mounted) return;
    Navigator.pop(context);
  }
}

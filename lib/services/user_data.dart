import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  String id;
  final String fullName;
  final String cnic;
  final String doe;
  final String email;
  final String password;
  final String number;
  final String mName;
  final String perAddress;
  final String currAddress;
  final String url;
  UserData({
    this.id = '',
    required this.fullName,
    required this.cnic,
    required this.doe,
    required this.email,
    required this.password,
    required this.number,
    required this.mName,
    required this.perAddress,
    required this.currAddress,
    required this.url,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'Name': fullName,
        'CNIC': cnic,
        'DoE': doe,
        'Email': email,
        'Password': password,
        'number': number,
        'motherName': mName,
        'perAddress': perAddress,
        'currAddress': currAddress,
        'dpURL': url,
      };

  static UserData fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        fullName: json['Name'],
        cnic: json['CNIC'],
        doe: json['DoE'],
        email: json['Email'],
        password: json['Password'],
        number: json['number'],
        mName: json['motherName'],
        perAddress: json['perAddress'],
        currAddress: json['currAddress'],
        url: json['dpURL'],
      );

  static Stream<List<UserData>> readUsers() => FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email!)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => UserData.fromJson(
                doc.data(),
              ),
            )
            .toList(),
      );

  static Future savePassToFirestore(UserData user) async {
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email!)
        .doc();
    user.id = docUser.id;

    final json = user.toJson();
    log('json = $json, userid = ${user.id}');
    await docUser.set(json);
    // await docUser.set(json);
  }
}

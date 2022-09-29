// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static File? file;
  static Future<void> selectFile(
      String docID, String location, bool check) async {
    String? urlDownload;
    String id = FirebaseFirestore.instance
        .collection(
          FirebaseAuth.instance.currentUser!.email!,
        )
        .doc(docID)
        .toString();
    if (!check) {
      id = FirebaseFirestore.instance
          .collection(
            FirebaseAuth.instance.currentUser!.email!,
          )
          .doc(docID)
          .toString();
    } else if (check) {
      id = docID;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    PlatformFile? pickedFile;

    if (result != null) {
      pickedFile = result.files.first;
      log(pickedFile.toString());
      file = File(pickedFile.path!);
      log(file.toString());
    }

    final path = '/$location/$id/${pickedFile?.name}';
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file!);
    final upload = ref.putFile(file!);
    final snapshot = await upload.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();
    log('url is = $urlDownload');
    if (!check) {
      final docUser = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email!)
          .doc(docID);

      docUser.update(
        {
          "dpURL": urlDownload,
        },
      );
    }
    if (check) {
      final docUser = FirebaseFirestore.instance
          .collection("Parties")
          .doc(docID.toUpperCase());

      docUser.update(
        {
          "imgurl": urlDownload,
        },
      );
    }
  }
}

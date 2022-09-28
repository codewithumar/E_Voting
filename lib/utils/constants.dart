import 'dart:ui';

import 'package:e_voting/models/user_data.dart';

enum FieldMsgs {
  name,
  cnic,
  phone,
  doe,
  email,
  password,
  address,
  errormsgicon,
  successmsgicon,
  mothername,
  time,
}

class Constants {
  static Role convertStringToRole(
    String value,
  ) {
    late Role role;
    if (Role.admin.name == value) {
      role = Role.admin;
    } else {
      role = Role.voter;
    }
    return role;
  }

  static String convertRoleToString(Role value) {
    return value.name;
  }

  static const appname = 'E-Voting';

  static const primarycolor = Color(0xFF027314);
  static const lightGreen = Color(0xFF7FB787);
  static const greensnackbarColor = Color(0xff2DD36F);
  static const adminScreenButtonColor = Color(0xffE8F3EA);
  static const buttontextcolor = Color(0xFFFBFAFA);
  static const greyColor = Color(0xFF8893AC);
  static const redsnackbarColor = Color(0xffFF3939);
  static const yellowsnackbarColor = Color(0xffFFC409);
  static const textcolor = Color(0xffffffff);
  static const errorcolor = Color(0xffff0000);
  static const adminiconcolor = Color(0xff68A368);

  static List<Color> colors = [
    const Color.fromARGB(255, 150, 220, 150),
    const Color.fromARGB(255, 132, 200, 132),
    const Color.fromARGB(255, 129, 208, 129),
    const Color.fromARGB(255, 104, 195, 104),
    const Color.fromARGB(255, 91, 194, 91),
    const Color.fromARGB(255, 27, 141, 27),
  ];
}

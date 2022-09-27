import 'package:e_voting/utils/constants.dart';

enum Role { voter, admin }

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
  final Role role;
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
    required this.role,
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
        'role': role,
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
        role: Constants.convertStringToRole(json['role']),
      );
}

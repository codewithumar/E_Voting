// import 'package:flutter/services.dart';

// class DashFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     if (oldValue.text.length > newValue.text.length) {
//       return TextEditingValue(
//         text: newValue.text.toString(),
//         selection: TextSelection.collapsed(offset: newValue.text.length),
//       );
//     }

//     String newText = newValue.text.replaceAllMapped(
//         RegExp(r'.{5}'), (Match match) => '${match.group(0)} ');
//     newText = newText.substring(0, newText.length - 1);

//     return TextEditingValue(
//       text: newText.toString(),
//       selection: TextSelection.collapsed(offset: newText.length),
//     );
//   }
// }

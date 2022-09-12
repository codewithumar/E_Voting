// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:e_voting/utils/constants.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      required this.label,
      required this.labelText,
      this.obscure,
      this.controller,
      this.errormessage,
      this.fieldmessage,
      this.readOnly})
      : super(key: key);
  final String label;
  final String labelText;
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? errormessage;
  final String? fieldmessage;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText = (widget.obscure == true) ? true : false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff027314),
            ),
          ),
        ),
        Container(
          height: 65,
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: TextFormField(
            keyboardType:
                (widget.fieldmessage == "Cnic" || widget.fieldmessage == "DOE")
                    ? TextInputType.number
                    : TextInputType.text,
            controller: widget.controller,
            inputFormatters: (widget.fieldmessage == "Cnic")
                ? [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                    LengthLimitingTextInputFormatter(13),
                  ]
                : [],
            obscureText: _obscureText,
            readOnly: (widget.readOnly == true) ? true : false,
            decoration: InputDecoration(
              suffixIcon: (widget.obscure == true)
                  ? IconButton(
                      icon: Icon(
                        !_obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Constants.lightGreen,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      })
                  : const Text(''),
              hintText: widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              alignLabelWithHint: true,
              prefixText: "  ",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 203, 217, 205),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 10,
              ),
            ),
            validator: (value) {
              if (widget.fieldmessage == null && value!.isEmpty) {
                return widget.errormessage;
              } else if (widget.fieldmessage == "Cnic" &&
                  (value!.isEmpty) &&
                  value.length < 13) {
                return "Please enter correct 13 digit Cnic";
              } else if (widget.fieldmessage == "email" &&
                  !EmailValidator.validate(value!)) {
                return "Please enter correct email";
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:e_voting/utils/constants.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
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
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
            controller: widget.controller,
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
              hintText: (widget.fieldmessage == "password")
                  ? "*********"
                  : widget.labelText,
              labelStyle: const TextStyle(
                fontSize: 14,
              ),
              alignLabelWithHint: true,
              prefixText: "  ",
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Constants.errorcolor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
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
                log("1");
                return widget.errormessage;
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

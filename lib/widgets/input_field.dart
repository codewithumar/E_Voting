// ignore_for_file: must_be_immutable, depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:e_voting/utils/constants.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.labeltext,
    required this.hintText,
    this.controller,
    this.errormessage,
    this.fieldmessage,
    this.readOnly,
  }) : super(key: key);
  final String labeltext;
  final String hintText;
  final TextEditingController? controller;

  final bool? readOnly;
  final String? errormessage;
  final String? fieldmessage;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.labeltext,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff027314),
            ),
          ),
        ),
        Container(
          height: (widget.fieldmessage == 'Address') ? 80 : 65,
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: TextFormField(
            keyboardType: (widget.fieldmessage == "Cnic" ||
                    widget.fieldmessage == "DOE" ||
                    widget.fieldmessage == "phone")
                ? TextInputType.number
                : TextInputType.text,
            controller: widget.controller,
            inputFormatters: (widget.fieldmessage == "Cnic" ||
                    widget.fieldmessage == "phone")
                ? [
                    LengthLimitingTextInputFormatter(13),
                  ]
                : [],
            readOnly: (widget.readOnly == true) ? true : false,
            decoration: InputDecoration(
              suffix: (widget.fieldmessage == "DOE")
                  ? IconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Constants.lightGreen,
                      ),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2050),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            widget.controller!.text =
                                DateFormat('MM/yyyy').format(pickedDate);
                          });
                        }
                      })
                  : const Text(''),
              hintText: (widget.fieldmessage == "password")
                  ? "*********"
                  : widget.hintText,
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
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Constants.errorcolor,
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
            maxLength: (widget.fieldmessage == 'Address') ? 250 : null,
            maxLines: (widget.fieldmessage == 'Address') ? 10 : null,
            validator: (value) {
              if (widget.fieldmessage == null && value!.isEmpty) {
                log("1");
                return widget.errormessage;
              } else if (widget.fieldmessage == "Cnic" &&
                  value!.length < 13 &&
                  value.isEmpty) {
                log("2");
                return "Please enter correct 13 digit Cnic";
              } else if (widget.fieldmessage == "email" &&
                  !EmailValidator.validate(value!)) {
                log("3");
                return widget.errormessage;
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

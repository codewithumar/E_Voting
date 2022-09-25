// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
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
  final FieldMsgs? fieldmessage;

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
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: TextFormField(
            keyboardType: (widget.fieldmessage == FieldMsgs.cnic ||
                    widget.fieldmessage == FieldMsgs.doe ||
                    widget.fieldmessage == FieldMsgs.phone)
                ? TextInputType.number
                : (widget.fieldmessage == FieldMsgs.email)
                    ? TextInputType.emailAddress
                    : (widget.fieldmessage == FieldMsgs.name)
                        ? TextInputType.name
                        : TextInputType.text,
            controller: widget.controller,
            onTap: (widget.fieldmessage == FieldMsgs.doe)
                ? () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2032, 12, 31),
                    );
                    if (pickedDate != null) {
                      setState(
                        () {
                          widget.controller!.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        },
                      );
                    }
                  }
                : () {},
            inputFormatters: (widget.fieldmessage == FieldMsgs.cnic)
                ? [
                    LengthLimitingTextInputFormatter(15),
                  ]
                : (widget.fieldmessage == FieldMsgs.phone)
                    ? [
                        LengthLimitingTextInputFormatter(13),
                      ]
                    : [],
            readOnly: (widget.readOnly == true) ? true : false,
            decoration: InputDecoration(
              suffixIcon: (widget.fieldmessage == FieldMsgs.doe)
                  ? const Image(
                      image: AssetImage(
                        "assets/images/icons/calendar.png",
                      ),
                    )
                  : (widget.fieldmessage == FieldMsgs.time)
                      ? const Image(
                          image: AssetImage(
                            "assets/images/icons/clock.png",
                          ),
                        )
                      : null,
              hintText: widget.hintText,
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
            maxLength: (widget.fieldmessage == FieldMsgs.address) ? 250 : null,
            validator: (value) {
              if (value!.isEmpty) {
                log("All xEmpty field validation error");
                return widget.errormessage;
              } else if (widget.fieldmessage == FieldMsgs.cnic &&
                  (value.length != 15 ||
                      value.isEmpty ||
                      value[5] != '-' ||
                      value[13] != '-')) {
                log("Cnic validation error");
                return "Please enter correct formate 33333-1234567-8";
              } else if (widget.fieldmessage == FieldMsgs.phone &&
                  (value.length != 13 || value.isEmpty || value[5] != '-')) {
                log("phone validation error");
                return "Please enter correct Number e.g 92333-1234567";
              } else if (widget.fieldmessage == FieldMsgs.doe &&
                  (value.isEmpty || value[2] != '/')) {
                log("DOE validation error");
                return "Please enter correct date";
              } else if (widget.fieldmessage == FieldMsgs.email &&
                  !EmailValidator.validate(value)) {
                log("Email validation error");
                return widget.errormessage;
              } else if (widget.fieldmessage == FieldMsgs.address &&
                  value.length < 10) {
                log("address validation error");
                return widget.errormessage;
              } else if (widget.fieldmessage == FieldMsgs.mothername &&
                  value.length < 4) {
                log("Mothername validation error");
                return widget.errormessage;
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}

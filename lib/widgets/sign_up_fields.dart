// ignore_for_file: must_be_immutable

import 'package:e_voting/services/dash_formatter.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      required this.label,
      required this.labelText,
      this.obscure,
      this.controller,
      this.readOnly})
      : super(key: key);
  final String label;
  final String labelText;
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;

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
          height: 55,
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          child: TextFormField(
            controller: widget.controller,
            // inputFormatters: <TextInputFormatter>[
            //   LengthLimitingTextInputFormatter(15),
            //   DashFormatter(),
            // ],
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
                fontSize: 14,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
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

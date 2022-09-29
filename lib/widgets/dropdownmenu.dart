import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  final items = [
    'Pakistan Muslim League N',
    'Mutehda Quoami Movement',
    'Pakistan Tehreek Insaaf',
    'Pakistan People`s Party',
  ];

  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Parties",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff027314),
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 203, 217, 205),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  items: items.map(buildmenuitem).toList(),
                  onChanged: (v) => setState(() {
                        value = v;
                      })),
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildmenuitem(String e) => DropdownMenuItem(
        value: e,
        child: Text(
          e,
        ),
      );
}

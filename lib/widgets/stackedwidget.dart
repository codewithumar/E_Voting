import 'package:flutter/material.dart';

class StackedWidgets extends StatelessWidget {
  const StackedWidgets({
    required this.items,
    required this.size,
    super.key,
  });

  final List<Widget> items;
  final double size;

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = size - 20;
          final value = Container(
            margin: EdgeInsets.only(left: left * index),
            width: size,
            height: size,
            child: item,
          );
          return MapEntry(index, value);
        })
        .values
        .toList();
    return Stack(
      textDirection: TextDirection.ltr,
      children: allItems,
    );
  }
}

Widget buildStackedImages() {
  const double size = 40;
  final urls = [
    'assets/images/partiesimage/pmln.png',
    'assets/images/partiesimage/ppp.png',
    'assets/images/partiesimage/pti.png',
  ];

  final items = urls
      .map(
        (url) => ClipOval(
          child: Image.asset(
            url,
            fit: BoxFit.cover,
          ),
        ),
      )
      .toList();

  return StackedWidgets(
    items: items,
    size: size,
  );
}

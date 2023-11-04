// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  SmallText({
    Key? key,
    this.color = Colors.grey,
    required this.text,
    this.height = 1.2,
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size == 0 ? Dimensions.font12 : size,
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: "Lato"),
    );
  }
}

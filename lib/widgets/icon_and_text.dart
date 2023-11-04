import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndWidget extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String text;
  final Color iconColor;
  IconAndWidget(
      {super.key,
      required this.icon,
      this.color = Colors.grey,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          color: color,
        )
      ],
    );
  }
}

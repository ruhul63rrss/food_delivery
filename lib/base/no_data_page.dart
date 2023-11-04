import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imgPath;
  const NoDataPage(
      {super.key,
      required this.text,
      this.imgPath = "assets/images/empty.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgPath,
          width: MediaQuery.of(context).size.width * 0.30,
          height: MediaQuery.of(context).size.height * 0.30,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontFamily: 'Lato',),
        ),
      ],
    );
  }
}

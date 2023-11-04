import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: text),
          Row(
            children: [
              Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: AppColors.mainColor,
                          size: 15,
                        )),
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              SmallText(text: '4.5'),
              SizedBox(
                width: Dimensions.width30,
              ),
              SmallText(text: '1287'),
              SizedBox(
                width: Dimensions.width10,
              ),
              SmallText(text: 'Comments')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndWidget(
                  icon: Icons.circle_sharp,
                  text: "Normal",
                  iconColor: AppColors.iconColor1),
              IconAndWidget(
                  icon: Icons.add_location,
                  text: "1.7Km",
                  iconColor: AppColors.iconColor1),
              IconAndWidget(
                  icon: Icons.access_time_outlined,
                  text: "12min",
                  iconColor: AppColors.iconColor1)
            ],
          )
        ]);
  }
}

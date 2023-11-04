// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product-controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RecommendedFoodDetail extends StatelessWidget {
final  int pageId;
  final String page;
  RecommendedFoodDetail({super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var recommendproduct =
        Get.find<RecommendedProductController>().recommendedproductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(recommendproduct, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                  
                  if(page=="cartpage")
                  {
 Get.toNamed(RouteHelper.getCartPage());
                  }else
                  {
                     Get.toNamed(RouteHelper.getInitial());

                  }
                      },
                      child: AppIcon(icon: Icons.clear)),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCartPage());
                            },
                            child: AppIcon(
                              icon: Icons.shopping_cart_outlined,
                            ),
                          ),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    iconColor: Colors.transparent,
                                    backgroundCOlor: AppColors.mainColor,
                                    size: 20,
                                  ))
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 0,
                                  child: SmallText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 10,
                                    color: Colors.white,
                                  ))
                              : Container()
                        ],
                      );
                    },
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            topLeft: Radius.circular(Dimensions.radius20))),
                    width: double.maxFinite,
                    child: Center(
                        child: BigText(
                      text: "Chiness Side",
                      size: Dimensions.font20,
                    ))),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: Dimensions.pageView,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                AppConstants.BASE_URL + "/uploads/" + recommendproduct.img!,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
            ),
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width10, right: Dimensions.width10),
                  child: ExpandableText(text: recommendproduct.description!)),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: Dimensions.width20 * 2.5,
                      right: Dimensions.width20 * 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove,
                          iconColor: Colors.white,
                          backgroundCOlor: AppColors.mainColor,
                        ),
                      ),
                      BigText(
                          text: "\$ ${recommendproduct.price!} " +
                              "X" +
                              " ${controller.inCartItems}"),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          icon: Icons.add,
                          iconColor: Colors.white,
                          backgroundCOlor: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: Dimensions.height120,
                  padding: EdgeInsets.only(
                      top: Dimensions.height30,
                      bottom: Dimensions.height30,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: AppColors.buttonBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20)),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                            size: 40,
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(recommendproduct);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20)),
                          child: BigText(
                              text:
                                  "\$ ${recommendproduct.price!} | Add to Cart"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product-controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height30 * 2,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundCOlor: AppColors.mainColor,
                    ),
                    SizedBox(
                      width: Dimensions.width30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.initial);
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundCOlor: AppColors.mainColor,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundCOlor: AppColors.mainColor,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height40 * 2.5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height10),
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (cartcontroller) {
                                var cartlist = cartcontroller.getItems;
                                return ListView.builder(
                                    itemCount: cartlist.length,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        height: Dimensions.height20 * 5,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                var popularProductindex = Get.find<
                                                        PopularProductController>()
                                                    .popularproductList
                                                    .indexOf(cartlist[index]
                                                        .product!);
                                                if (popularProductindex >= 0) {
                                                  Get.toNamed(RouteHelper
                                                      .getPopularFood(
                                                          popularProductindex,
                                                          "cartpage"));
                                                } else {
                                                  var recommendedProductindex =
                                                      Get.find<
                                                              RecommendedProductController>()
                                                          .recommendedproductList
                                                          .indexOf(
                                                              cartlist[index]
                                                                  .product!);

                                                  if (recommendedProductindex <
                                                      0) {
                                                    Get.snackbar(
                                                        "History Product",
                                                        "Product Preview is not Available for History Product",
                                                        backgroundColor:
                                                            AppColors.mainColor,
                                                        colorText:
                                                            Colors.white);
                                                  } else {
                                                    Get.toNamed(RouteHelper
                                                        .getRecommendedFood(
                                                            recommendedProductindex,
                                                            "cartpage"));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              "/uploads/" +
                                                              cartcontroller
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  color: Colors.yellow,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                width: Dimensions.width20 * 5,
                                                height: Dimensions.height20 * 5,
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: Dimensions.height20 * 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  BigText(
                                                      text: cartcontroller
                                                          .getItems[index]
                                                          .name!),
                                                  SmallText(text: "Juice"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      BigText(
                                                        text: cartlist[index]
                                                            .price
                                                            .toString(),
                                                        color: Colors.red,
                                                        size: 18,
                                                      ),
                                                      Row(children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartcontroller.addItem(
                                                                  cartlist[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                            )),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .width5),
                                                        BigText(
                                                            text: cartcontroller
                                                                .getItems[index]
                                                                .quantity
                                                                .toString()),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .width5),
                                                        GestureDetector(
                                                            onTap: () {
                                                              cartcontroller.addItem(
                                                                  cartlist[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                            ))
                                                      ]),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      );
                                    });
                              },
                            )),
                      ))
                  : NoDataPage(text: "Your Cart Is Empty");
            }),
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartcontroller) {
            return Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: cartcontroller.getItems.length > 0
                      ? AppColors.buttonBackgroundColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30)),
              child: cartcontroller.getItems.length > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20)),
                          child: BigText(
                            text: "\$ " + cartcontroller.totalAmount.toString(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //      controller.addItem(recommendproduct);

                            print("Clicked check out ");
                            print(cartcontroller.getItems);
                            cartcontroller.addToHistory();
                            print("Added to history");
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
                            child: BigText(text: " Check Out"),
                          ),
                        )
                      ],
                    )
                  : Container(),
            );
          },
        ));
  }
}

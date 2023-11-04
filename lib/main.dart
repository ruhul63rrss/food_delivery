import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';

import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product-controller.dart';

import 'package:food_delivery/route/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;
//height =897 width=423

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            initialRoute: RouteHelper.getSplashSceen(), //no nedd to use it
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}

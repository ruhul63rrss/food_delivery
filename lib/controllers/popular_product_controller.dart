// ignore_for_file: unused_element, avoid_print, empty_catches, curly_braces_in_flow_control_structures, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
class PopularProductController extends GetxController {
  final PopularProductrepo popularProductrepo;
  PopularProductController({required this.popularProductrepo});
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularproductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _incartItems = 0;
  int get inCartItems => _incartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductrepo.getPopularProductList();
    if (response.statusCode == 200) {
  //    print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
   //   print("Controller NOT initialized ${response.status.toString()}");
    }
  }

  void setQuantity(bool isIncreament) {
    if (isIncreament) {
      _quantity = checkQuantity(_quantity + 1);
    //  print("Increament: ${_quantity}");
    } else {
      _quantity = checkQuantity(_quantity - 1);
    //  print("Decreament: ${_quantity}");
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_quantity + inCartItems) < 0) {
      Get.snackbar("Item Count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_incartItems > 0) {
        _quantity = -_incartItems;
        return _quantity;
      }

      return 0;
    } else if ((_quantity + inCartItems) > 25) {
      Get.snackbar("Item Count", "You can't add more !",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);

      return 25;
    } else
      return quantity;
  }

  void initProduct(ProductModel productModel, CartController cart) {
    _quantity = 0;
    _incartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(productModel);
    //if exist
    //get from storage _incartItem=3
  //  print("Exist :" + exist.toString());
    if (exist) {
      _incartItems = _cart.getQuantity(productModel);
    }
   // print("Quantity  " + _incartItems.toString());
  }
  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _incartItems = _cart.getQuantity(product);
    //_cart.item.forEach((key, value) {
      // print("The id is " +
      //     value.id.toString() +
      //     "The Quantity :" +
      //     value.quantity.toString());
    //});
    update();
  }
  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}

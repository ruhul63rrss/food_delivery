
import 'dart:convert';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> carthistory = [];
  void addToCartItemList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    cart = [];
    // cartList.forEach((element) {
    //   return cart.add(jsonEncode(element));
    // });
//Same as prevoius
    cartList.forEach((element) {
      element.time = time;

      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  //  print(sharedPreferences.getStringList(AppConstants.CART_LIST));

    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;

    //  print('Inside GetcartList' + carts.toString());
    }
    List<CartModel> cartList = [];
    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });
//Same as previous expression
    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      carthistory = [];
      carthistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    carthistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }
  void addCartHistoryList() {
 //   print("Add to history in Cart Repo 1");
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
   //   print("Add to history in IF lOOP");
      // print(carthistory[0]);
      carthistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
   //   print("Add to history in IF lOOP 2");
   //   print(carthistory[0]);
    }
  //  print("Hisoty outer Foor  Loop");
    for (int i = 0; i < cart.length; i++) {
    /////  print("Hisoty inner Foor Loop");
   //   print("History List" + cart[i]);
      carthistory.add(cart[i]);
    }
    removeCart();
   // print("Removed after fuction");
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, carthistory);
 //   print("History length" + getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
  //    print("Time is :" + getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart() {
    //print("removed in fuction");
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}

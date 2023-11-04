// ignore_for_file: prefer_final_fields, prefer_interpolation_to_compose_strings

import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/model/cart_model.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get item => _items;

  //Stored item in shared Preferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalquantity;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalquantity = value.quantity! + quantity;
        return CartModel(
            value.id,
            value.name,
            value.price,
            value.img,
            DateTime.now().toString(),
            true,
            value.quantity! + quantity,
            product);
      });
      if (totalquantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(product.id, product.name, product.price, product.img,
              DateTime.now().toString(), true, quantity, product);
        });
      } else {
        Get.snackbar("Item Adding ", "Cannot add product");
      }
    }
    cartRepo.addToCartItemList(getItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
  //  print("Clicked Add to History");
    cartRepo.addCartHistoryList();
//     print("Added");
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartItemList(getItems);
  }
}

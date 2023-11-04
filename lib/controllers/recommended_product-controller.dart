// ignore_for_file: unused_element, avoid_print, empty_catches, unused_import
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/model/products_model.dart';
import 'package:get/get.dart';
class RecommendedProductController extends GetxController {
  final RecommendedProductrepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedproductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      //print("got products recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
    //  print(_recommendedProductList);
      _isLoaded = true;
      update();
    } else {
     print("Controller NOT initialized ${response.status.toString()}");
    }
  }
}

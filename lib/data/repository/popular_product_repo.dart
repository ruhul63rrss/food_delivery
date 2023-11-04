import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductrepo extends GetxService {
  final ApiClient apiClient;
  PopularProductrepo({required this.apiClient});
  Future<Response> getPopularProductList() async {
   // print("Popular Productrepo");
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}

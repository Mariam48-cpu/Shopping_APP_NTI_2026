import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/core/network/result_api.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../home/data/dto/product_dto.dart';

class ProductsByCategoryApi {
  Future<ResultApi<List<ProductDto>>> getAllProductsByCategory(
    String slug,
  ) async {
    try {
      Uri url = Uri.parse(
        ApiConstant.baseUrl + ApiConstant.productsByCategory(slug),
      );
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );
      var json = jsonDecode(response.body);
      var productsList = json['list'] ?? json;
      List<ProductDto> products = productsList
          .map((item) => ProductDto.fromJson(item))
          .toList();
      return Success(data: products);
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}

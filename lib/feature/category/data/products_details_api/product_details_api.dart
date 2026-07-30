import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/core/network/result_api.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/model/item/product_item_dto.dart';

class ProductDetailsApi {
  Future<ResultApi<ProductItemDto>> getProductDetails(int id) async {
    try {
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.productsDetails(id));
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );
      var json = jsonDecode(response.body);
      ProductItemDto productDto = ProductItemDto.fromJson(json);
      return Success<ProductItemDto>(data: productDto);
    } catch (e) {
      return Error<ProductItemDto>(messageError: e.toString());
    }
  }
}

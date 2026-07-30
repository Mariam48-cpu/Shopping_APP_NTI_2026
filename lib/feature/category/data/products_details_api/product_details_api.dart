import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/core/network/result_api.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/product_details_dto.dart';

class ProductDetailsApi {
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int id) async {
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
      ProductDetailsDto productDto = ProductDetailsDto.fromJson(json);
      return Success<ProductDetailsDto>(data: productDto);
    } catch (e) {
      return Error<ProductDetailsDto>(messageError: e.toString());
    }
  }
}

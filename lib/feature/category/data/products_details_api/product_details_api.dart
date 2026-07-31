import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/model/item/product_item_dto.dart';

class ProductDetailsApi {
  Future<ResultApi<ProductItemDto>> getProductDetails(int id) async {
    try {
       String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.productsDetails(id));
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
           if (savedToken != null) 'Authorization': 'Bearer $savedToken',
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

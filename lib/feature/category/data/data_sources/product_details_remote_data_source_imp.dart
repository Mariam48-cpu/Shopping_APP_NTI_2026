import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/product_details_remote_data_source_interface.dart';

import '../../../../core/constants/api_constants.dart';
@Injectable(as: ProductDetailsRemoteDataSourceInterface)
class ProductDetailsRemoteDataSourceImp implements ProductDetailsRemoteDataSourceInterface {
  @override
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
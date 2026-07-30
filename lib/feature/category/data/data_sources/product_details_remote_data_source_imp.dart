import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/product_details_remote_data_source_interface.dart';
import 'package:shopping_app/feature/category/data/models/product_details_dto.dart';

import '../../../../core/constants/api_constants.dart';
@Injectable(as: ProductDetailsRemoteDataSourceInterface)
class ProductDetailsRemoteDataSourceImp implements ProductDetailsRemoteDataSourceInterface {
  @override
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
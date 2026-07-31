import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/category/data/data_sources/product_details_data_source_interface.dart';
import 'package:shopping_app/feature/category/data/models/product_details_dto.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_keys.dart';
import '../../../../core/storage_helper/secure_storage_helper.dart';

@Injectable(as: ProductDetailsRemoteDataSourceInterface)
class ProductDetailsRemoteDataSourceImp
    implements ProductDetailsRemoteDataSourceInterface {
  @override
  Future<ResultApi<ProductDetailsDto>> getProductDetails(int id) async {
    try {
      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );
      Uri url = Uri.parse(
        ApiConstant.baseUrl + ApiConstant.productsDetails(id),
      );
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null && savedToken.isNotEmpty)
            'Authorization': 'Bearer $savedToken',
        },
      );
      var json = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        ProductDetailsDto productDto = ProductDetailsDto.fromJson(json);
        return Success<ProductDetailsDto>(data: productDto);
      } else {
        return Error<ProductDetailsDto>(
          messageError: json['message'] ?? 'Failed to load product details',
        );
      }
    } catch (e) {
      return Error<ProductDetailsDto>(messageError: e.toString());
    }
  }
}

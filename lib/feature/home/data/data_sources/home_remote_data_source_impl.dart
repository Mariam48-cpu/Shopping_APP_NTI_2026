import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/core/model/item/product_item_dto.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_keys.dart';
import '../../../../core/storage_helper/secure_storage_helper.dart';

@Injectable(as: HomeRemoteDataSourceInterface)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceInterface {
  @override
  Future<ResultApi<CategoryDto>> getCategories() async {
    try {
      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.categories),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null && savedToken.isNotEmpty)
            'Authorization': 'Bearer $savedToken',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return Success(data: CategoryDto.fromJson(json));
      }

      return Error(messageError: "Failed to load categories");
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<ProductDto>> getProducts() async {
    try {
      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.products),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null && savedToken.isNotEmpty)
            'Authorization': 'Bearer $savedToken',
        },
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Success(data: ProductDto.fromJson(json));
      }

      return Error(messageError: 'Failed to load products');
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}

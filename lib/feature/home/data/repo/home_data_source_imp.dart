import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
import 'package:shopping_app/feature/home/domain/repo/home_remote_data_source_interface.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/core/model/item/product_item_dto.dart';
import '../../../../core/constants/api_constants.dart';

@Injectable(as: HomeRemoteDataSourceInterface)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceInterface {
  @override
  Future<ResultApi<CategoryDto>> getCategories() async {
    try {
       String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.categories),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
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
       String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.products),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
           if (savedToken != null) 'Authorization': 'Bearer $savedToken',
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

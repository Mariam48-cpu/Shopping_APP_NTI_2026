import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/feature/home/data/dto/product_dto.dart';

@LazySingleton(as: HomeRemoteDataSourceInterface)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceInterface {
  @override
  Future<ResultApi<CategoryDto>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.categories),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.token}',
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
      
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.products),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.token}',
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

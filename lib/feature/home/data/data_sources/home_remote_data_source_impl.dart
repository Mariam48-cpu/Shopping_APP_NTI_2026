import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/core/network/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/feature/home/data/dto/product_dto.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<ResultApi<List<CategoryDto>>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.categories),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final categories = (json as List)
            .map((e) => CategoryDto.fromJson(e))
            .toList();

        return Success(data: categories);
      }

      return Error(messageError: "Failed to load categories");
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<List<ProductDto>>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.products),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final products = (json as List)
            .map((e) => ProductDto.fromJson(e))
            .toList();

        return Success(data: products);
      }

      return Error( messageError: '');
    } catch (e) {
      return Error( messageError: '');
    }
  }
}
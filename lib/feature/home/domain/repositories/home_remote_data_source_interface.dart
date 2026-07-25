import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/feature/home/data/dto/product_dto.dart';

abstract class HomeRemoteDataSourceInterface {
  Future<ResultApi<CategoryDto>> getCategories();

  Future<ResultApi<ProductDto>> getProducts();
}
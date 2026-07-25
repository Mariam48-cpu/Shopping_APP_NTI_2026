import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';

abstract interface class HomeRepository {
  Future<ResultApi<List<CategoryEntity>>> getCategories();

  Future<ResultApi<List<ProductEntity>>> getProducts();
}
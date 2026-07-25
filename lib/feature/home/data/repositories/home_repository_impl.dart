import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/data/data_sources/home_remote_data_source.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/feature/home/data/dto/product_dto.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ResultApi<List<CategoryEntity>>> getCategories() async {
    final result = await remoteDataSource.getCategories();

    if (result is Success<List<CategoryDto>>) {
      final categories = result.data
          .map((e) => CategoryEntity.fromDto(e))
          .toList();

      return Success(data: categories);
    }

    if (result is Error<List<CategoryDto>>) {
      return Error(messageError: result.messageError);
    }

    return Error(messageError: "Something went wrong");
  }

  @override
  Future<ResultApi<List<ProductEntity>>> getProducts() async {
    final result = await remoteDataSource.getProducts();

    if (result is Success<List<ProductDto>>) {
      final products = result.data
          .map((e) => ProductEntity.fromDto(e))
          .toList();

      return Success(data: products);
    }

    if (result is Error<List<ProductDto>>) {
      return Error(messageError: result.messageError);
    }

    return Error(messageError: "Something went wrong");
  }
}
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/feature/home/data/dto/product_dto.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart';
// todo:   add injection
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSourceInterface remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

@override
Future<ResultApi<CategoryEntity>> getCategories() async {
  final result = await remoteDataSource.getCategories();

  if (result is Success<CategoryDto>) {
    return Success(
      data: result.data?.toEntity(),
    );
  }

  if (result is Error<CategoryDto>) {
    return Error(messageError: result.messageError);
  }

  return Error(messageError: "Something went wrong");
}

@override
Future<ResultApi<ProductEntity>> getProducts() async {
  final result = await remoteDataSource.getProducts();

  if (result is Success<ProductDto>) {
    return Success(
      data: result.data?.toEntity(),
    );
  }

  if (result is Error<ProductDto>) {
    return Error(messageError: result.messageError);
  }

  return Error(messageError: "Something went wrong");
}

}
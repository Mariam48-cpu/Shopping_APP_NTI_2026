import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_remote_data_source_interface.dart';
import 'package:shopping_app/feature/home/data/dto/category_dto.dart';
import 'package:shopping_app/core/model/item/product_item_dto.dart';
import 'package:shopping_app/feature/home/domain/entities/category_entity.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/feature/home/domain/repositories/home_repository_interface.dart';
@LazySingleton(as: HomeRepository)
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
  final entity = result.data!.toEntity();
  return Success(data: entity);
}
  if (result is Error<ProductDto>) {
    return Error(messageError: result.messageError);
  }

  return Error(messageError: "Something went wrong");
}

}
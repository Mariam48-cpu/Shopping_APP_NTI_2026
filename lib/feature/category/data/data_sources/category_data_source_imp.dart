import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/model/item/product_item_entity.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/model/item/product_item_dto.dart';
import '../model/search_request_dto.dart';
import 'category_data_source_interface.dart';
import 'package:http/http.dart' as http;

@Injectable(as: CategoryRemoteDataSourceInterface)
class CategoryRemoteDataSourceImpl
    implements CategoryRemoteDataSourceInterface {
  @override
  Future<ResultApi<List<ProductItemDto>>> getProductsByCategory({
    required String slug,
    int skip = 0,
    int limit = 5,
  }) async {
    try {
      Uri url = Uri.parse(
        ApiConstant.baseUrl + ApiConstant.productsByCategory(slug),
      );
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List data = json['list'];
      List<ProductItemDto> productsList = data
          .map((item) => ProductItemDto.fromJson(item))
          .toList();
      return Success<List<ProductItemDto>>(data: productsList);
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<List<ProductItemEntity>>> productsBySearch({
    required String search,
    int skip = 0,
    int limit = 5,
  }) async {
    var requestDto = SearchRequestDto(search: search, skip: 0, limit: 5);
    try {
      Uri url = Uri.parse("${ApiConstant.baseUrl}${ApiConstant.search}");
      var response = await http.post(
        url,
        body: jsonEncode(requestDto.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<dynamic> jsonList = json['list'] ?? [];
        List<ProductItemDto> productsList = jsonList
            .map((item) => ProductItemDto.fromJson(item))
            .toList();
        return Success(data: productsList.map((e) => e.toEntity()).toList());
      } else {
        return Error(messageError: json['message']);
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}

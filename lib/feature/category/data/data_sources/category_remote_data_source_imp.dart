import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../home/data/dto/product_dto.dart';
import 'category_remote_data_source_interface.dart';
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
}

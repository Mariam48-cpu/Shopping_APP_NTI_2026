import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import '../../../../../core/data/models/product_item_dto.dart';
import 'category_remote_data_source_interface.dart';
import 'package:http/http.dart' as http;
@Injectable(as :CategoryRemoteDataSourceInterface )
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSourceInterface {
  @override
  Future<ResultApi<List<ProductDto>>> getProductsByCategory({required String slug, int skip = 0, int limit = 5})async {
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiConstants.productsByCategory(slug));
      var response =await http.get(url);
      var json = jsonDecode(response.body);
      List jsonList = json['products'] ?? json;
      List<ProductDto> productsList = jsonList
          .map((item) => ProductDto.fromJson(item))
          .toList();
      return Success(data: productsList);
    }catch(e){
      return Error(messageError: e.toString());
    }
    }
  }





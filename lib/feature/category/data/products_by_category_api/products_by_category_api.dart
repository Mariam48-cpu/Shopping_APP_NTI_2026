import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/data/models/product_item_dto.dart';
import 'package:shopping_app/core/network/result_api.dart';

class ProductsByCategoryApi {

  Future<ResultApi<List<ProductDto>>> getAllProductsByCategory(String slug)async{
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiConstants.productsByCategory(slug));
      var response = await http.get(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.token}',
        },);
      var json = jsonDecode(response.body);
      var productsList = json['products'] ?? json;
      List<ProductDto> products = productsList
          .map((item) => ProductDto.fromJson(item))
          .toList();
      return Success(data: products);
    }catch(e){
      return Error(messageError: e.toString());
    }
   


  }




}
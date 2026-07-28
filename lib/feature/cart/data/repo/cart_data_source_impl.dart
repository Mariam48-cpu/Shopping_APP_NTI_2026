import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';

@Injectable(as: CartDataSourceInterface)
class CartRemoteDataSourceImpl implements CartDataSourceInterface {
  @override
  Future<ResultApi<CartDto>> getCart() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.getCart),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );
      print(ApiConstant.token);
      print('${ApiConstant.baseUrl}${ApiConstant.getCart}');

      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final responseDto = CartDto.fromJson(json);

        return Success(data: responseDto);
      }

      return Error(
        messageError: "Status: ${response.statusCode}\n${response.body}",
      );
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addToCart({required int productId}) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.addCart}'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
        body: jsonEncode({"productId": productId}),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        return Success(data: json["message"]);
      }

      return Error(messageError: "Failed to add item");
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<String>> deleteCart({required int productId}) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.deleteCart}/$productId'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return Success(data: json["message"]);
      }

      return Error(messageError: "Delete failed");
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
import 'package:shopping_app/feature/cart/domain/repo/cart_data_source_interface.dart';
import 'package:shopping_app/feature/cart/data/dto/cart_dto.dart';

@Injectable(as: CartDataSourceInterface)
class CartRemoteDataSourceImpl implements CartDataSourceInterface {
  @override
  Future<ResultApi<CartDto>> getCart() async {
    try {
      String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.getCart),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
        },
      );

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
      String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final response = await http.post(
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.addCart}'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
        },
        body: jsonEncode({"productId": productId}),
      );
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
      String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final request = http.Request(
        'DELETE',
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.deleteCart}'),
      );

      request.headers.addAll({
        if (savedToken != null) 'Authorization': 'Bearer $savedToken',
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      request.body = jsonEncode({"productId": productId.toString()});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
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

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
import 'package:shopping_app/feature/favorite/data/dto/favorite_dto.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_data_source_interface.dart';

@Injectable(as: FavoriteDataSourceInterface)
class FavoriteDataSourceImp implements FavoriteDataSourceInterface {
  @override
  Future<ResultApi<FavoriteEntity>> getFavorite() async {
    String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
      key: AppKeys.token,
    );
    try {
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.getFavourite),
        headers: {
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        print("RAW RESPONSE:");
        print(response.body);
        print(jsonEncode(data));
        return Success(data: FavoriteDto.fromJson(data).toEntity());
      } else {
        return Error(
          messageError: "Status: ${response.statusCode}\n${response.body}",
        );
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addFavorite({required String productId}) async {
    try {
      String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.addToFavourite),
        headers: {
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"productId": productId}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(
          data: data["message"] ?? "Added to favorite successfully",
        );
      } else {
        return Error(
          messageError: "Status: ${response.statusCode}\n${response.body}",
        );
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<String>> deleteFavorite({required String productId}) async {
    try {
      String? savedToken = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );
      final request = http.Request(
        'DELETE',
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.deleteFavourite}'),
      );
      request.headers.addAll({
        "Content-Type": "application/json",
        "Accept": "application/json",
        if (savedToken != null) 'Authorization': 'Bearer $savedToken',
      });
      request.body = jsonEncode({"productId": productId.toString()});
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(data: data["message"] ?? "Removed successfully");
      } else {
        return Error(messageError: data["message"]);
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }
}

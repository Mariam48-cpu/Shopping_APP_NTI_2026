import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/favorite/data/dto/favorite_dto.dart';
import 'package:shopping_app/feature/favorite/domain/entities/favorite_entity.dart';
import 'package:shopping_app/feature/favorite/domain/repo/favorite_data_source_interface.dart';

@Injectable(as: FavoriteDataSourceInterface)
class FavoriteDataSourceImp implements FavoriteDataSourceInterface {
  @override
  Future<ResultApi<FavoriteEntity>> getFavorite() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.getFavourite),
        headers: {
          "Authorization": "Bearer ${ApiConstant.token}",
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
      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.addToFavourite),
        headers: {
          "Authorization": "Bearer ${ApiConstant.token}",
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
      final request = http.Request(
        'DELETE',
        Uri.parse('${ApiConstant.baseUrl}${ApiConstant.deleteFavourite}'),
      );

      request.headers.addAll({
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${ApiConstant.token}",
      });

      request.body = jsonEncode({"productId": productId.toString()});

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("STATUS = ${response.statusCode}");
      print("BODY = ${response.body}");
      final data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Success(data: data["message"] ?? "Removed successfully");
      } else {
        return Error(messageError: data["message"]);
      }
    } catch (e, s) {
      print("EXCEPTION = $e");
      print(s);
      return Error(messageError: e.toString());
    }
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';

import 'package:shopping_app/feature/account/data/model/account_model.dart';
import 'package:shopping_app/feature/account/data/model/update_account_model.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_data_source_interface.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountDataSourceImp implements AccountDataSourceInterface {
  @override
  Future<ResultApi<AccountEntity>> getAccount() async {
    try {
      final token = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );

      final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.account),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = UserDataDto.fromJson(json);

        return Success<AccountEntity>(data: dto.toEntity());
      } else {
        final json = jsonDecode(response.body);
        return Error<AccountEntity>(
          messageError: json["message"] ?? "Failed to load account",
        );
      }
    } catch (e) {
      return Error<AccountEntity>(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<String>> updateAccount({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String currentImage,
    XFile? image,
  }) async {
    try {
      final token = await serviceLocator<SecureStorageHelper>().getSecure(
        key: AppKeys.token,
      );

      String imagePath = currentImage;

      if (image != null) {
        imagePath = await uploadImage(image);
      }

      final response = await http.post(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.updateAccount),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "email": email,
          "address": address,
          "image": imagePath,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final dto = UpdateAccountDto.fromJson(json);

        return Success<String>(
          data: dto.message ?? "Account updated successfully",
        );
      } else {
        final json = jsonDecode(response.body);
        return Error<String>(
          messageError: json["message"] ?? "Failed to update account",
        );
      }
    } catch (e) {
      return Error<String>(messageError: e.toString());
    }
  }

  Future<String> uploadImage(XFile image) async {
    final token = await serviceLocator<SecureStorageHelper>().getSecure(
      key: AppKeys.token,
    );

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiConstant.baseUrl + ApiConstant.uploadImage),
    );

    request.headers.addAll({
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    });

    if (kIsWeb) {
      final Uint8List bytes = await image.readAsBytes();

      request.files.add(
        http.MultipartFile.fromBytes(
          "file",
          bytes,
          filename: image.name,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    } else {
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          image.path,
          contentType: MediaType("image", "jpeg"),
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);

      return json["image"] ?? json["url"] ?? json["data"]?["image"] ?? "";
    }

    throw Exception("Upload image failed: ${response.body}");
  }
}
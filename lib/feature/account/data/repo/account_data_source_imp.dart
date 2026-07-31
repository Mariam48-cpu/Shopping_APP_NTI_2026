import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_data_source_interface.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/storage_helper/secure_storage_helper.dart';
import '../../../../core/constants/app_keys.dart';
import '../model/account_model.dart';
import '../model/update_account_model.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountDataSourceImp implements AccountDataSourceInterface {
  @override
  Future<ResultApi<AccountEntity>> getAccount() async {
    try {
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.account);
      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null && savedToken.isNotEmpty)
            'Authorization': 'Bearer $savedToken',
          'Authorization': 'Bearer ${AppKeys.token}',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var data = UserDataDto.fromJson(json);

        return Success<AccountEntity>(data: data.toEntity());
      } else {
        Map<String, dynamic> json = jsonDecode(response.body);
        return Error<AccountEntity>(
          messageError: json['message'] ?? 'Failed to load data',
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
    File? image,
  }) async {
    try {
      String imagePath = currentImage;

      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );
      if (image != null) {
        imagePath = await uploadImage(image);
      }
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.updateAccount);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null && savedToken.isNotEmpty)
            'Authorization': 'Bearer $savedToken',
          'Authorization': 'Bearer ${AppKeys.token}',
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
        Map<String, dynamic> json = jsonDecode(response.body);
        var data = UpdateAccountDto.fromJson(json);
        return Success<String>(
          data: data.message ?? 'Data updated successfuly',
        );
      } else {
        Map<String, dynamic> json = jsonDecode(response.body);
        return Error<String>(
          messageError: json['message'] ?? 'Failed update data',
        );
      }
    } catch (e) {
      return Error<String>(messageError: e.toString());
    }
  }

  Future<String> uploadImage(File image) async {
    String? savedToken = await SecureStorageHelper.instance.getSecure(
      key: AppKeys.token,
    );
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiConstant.baseUrl + ApiConstant.uploadImage),
    );
    request.headers.addAll({
      if (savedToken != null && savedToken.isNotEmpty)
        'Authorization': 'Bearer $savedToken',
      'Authorization': 'Bearer ${AppKeys.token}',
      "Accept": "application/json",
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        image.path,
        contentType: http.MediaType("image", "jpeg"),
      ),
    );
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return '';
    }
    throw Exception("Upload image failed");
  }
}

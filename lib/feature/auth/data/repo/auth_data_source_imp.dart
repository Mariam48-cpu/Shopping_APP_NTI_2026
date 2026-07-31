import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/secure_storage_helper.dart';
import 'package:shopping_app/feature/auth/data/model/login_response_dto.dart';
import 'package:shopping_app/feature/auth/data/model/register_request_dto.dart';
import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_data_source_interface.dart';

@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImp implements AuthDataSourceInterface {
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async {
    try {
      var requestDto = RegisterRequestDto(
        name: request.name,
        phone: request.phone,
        email: request.email,
        password: request.password,
        confirmPassword: request.confirmPassword,
      );

      String? savedToken = await SecureStorageHelper.instance.getSecure(
        key: AppKeys.token,
      );

      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.signup);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (savedToken != null) 'Authorization': 'Bearer $savedToken',
        },
        body: jsonEncode(requestDto.toJson()),
      );

      var responseBody = response.body;
      var json = jsonDecode(responseBody);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var dto = LoginResponseDto.fromJson(json);
        if (dto.token != null && dto.token!.isNotEmpty) {
          await SecureStorageHelper.instance.saveSecure(
            key: AppKeys.token,
            value: dto.token!,
          );
        }
        return Success(data: json['message']);
      } else {
        return Error(messageError: json['message'] ?? 'Unknown Error');
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.signin);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      var json = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var dto = LoginResponseDto.fromJson(json);
        if (dto.token != null && dto.token!.isNotEmpty) {
          await SecureStorageHelper.instance.saveSecure(
            key: AppKeys.token,
            value: dto.token!,
          );
        }
        return Success(data: dto.toEntity());
      } else {
        return Error(messageError: json['message'] ?? 'Unknown Error');
      }
    } catch (e) {
      return Error(messageError: e.toString());
    }
  }

}
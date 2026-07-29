import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_data_source_interface.dart';

import '../../../../core/constants/api_constants.dart';
import '../model/account_model.dart';
import '../model/update_account_model.dart';
@Injectable(as: AccountDataSourceInterface)
class AccountDataSourceImp implements AccountDataSourceInterface {
  @override
  Future<ResultApi<AccountEntity>> getAccount() async {
    try {
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.account);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
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
    File? image,
  }) async {
    try {
      Uri url = Uri.parse(ApiConstant.baseUrl + ApiConstant.updateAccount);

      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${ApiConstant.token}',
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "address": address,
          "image": "",
        }),
      );

      print(response.statusCode);
      print(response.body);

      // var request = http.MultipartRequest(
      //   'POST',
      //   Uri.parse(ApiConstant.baseUrl + ApiConstant.updateAccount),
      // );
      // request.headers.addAll({
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer ${ApiConstant.token}',
      // });
      // request.fields.addAll({
      //   'name': name,
      //   'phone': phone,
      //   'email': email,
      //   'address': address,
      // });
      // if (image != null) {
      //   print("Image path: ${image.path}");
      //   request.files.add(
      //
      //       await http.MultipartFile.fromPath(
      //         'image',
      //         image.path,
      //       ),
      //   );
      // }
      // print(request.fields);
      // print(request.files.length);
      // var streamedResponse = await request.send();

     // var response = await http.Response.fromStream(streamedResponse);
      print(response.statusCode);
      print(response.body);


      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> json = jsonDecode(response.body);
        var data = UpdateAccountDto.fromJson(json);
        return Success<String>(
          data: data.message ?? 'Data updated successfuly',
        );
      } else {
        print(response.statusCode);
        print(response.body);
        Map<String, dynamic> json = jsonDecode(response.body);
        return Error<String>(
          messageError: json['message'] ?? 'Failed update data',
        );
      }
    } catch (e) {
      print(e);
      return Error<String>(messageError: e.toString());
    }
  }
}

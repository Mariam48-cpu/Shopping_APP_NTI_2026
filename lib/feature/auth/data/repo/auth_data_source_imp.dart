import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/api_constants.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/auth/data/model/register_request_dto.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_data_source_interface.dart';
@Injectable(as: AuthDataSourceInterface)
class AuthDataSourceImp implements AuthDataSourceInterface{
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request)async {
    try{
      var requestDto=RegisterRequestDto(
        name: request.name,
        phone: request.phone,
        email: request.email,
        password: request.password,
        confirmPassword: request.confirmPassword,

      );
      Uri url=Uri.parse(ApiConstant.baseUrl+ApiConstant.signUp);
      var response= await http.post(url,headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${ApiConstant.token}',
      },
      body: jsonEncode(requestDto.toJson()));
      var responseBody=response.body;
      var json=jsonDecode(responseBody);
      if(response.statusCode>=200&&response.statusCode<300){
        return Success(data: json['message']);
      }else{
        return Error(messageError: json['message']);
      }


    }catch(e){
      return Error(messageError: e.toString());
    }
    }
  }


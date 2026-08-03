import 'package:shopping_app/core/network/result_api.dart';
import '../entities/login_response_entity.dart';
import '../entities/register_request_entity.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity request);
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
}
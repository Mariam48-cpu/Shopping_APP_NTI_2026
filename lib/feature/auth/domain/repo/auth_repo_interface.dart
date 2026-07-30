import 'package:shopping_app/core/network/result_api.dart';
import '../entities/register_request_entity.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity request);
}
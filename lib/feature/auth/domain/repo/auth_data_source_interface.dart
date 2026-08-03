import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';
import '../../../../core/network/result_api.dart';
import '../entities/register_request_entity.dart';

abstract interface class AuthDataSourceInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity request);
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  });
}
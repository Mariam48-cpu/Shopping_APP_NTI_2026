import '../../../../core/network/result_api.dart';
import '../entities/register_request_entity.dart';

abstract interface class AuthDataSourceInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity request);
}
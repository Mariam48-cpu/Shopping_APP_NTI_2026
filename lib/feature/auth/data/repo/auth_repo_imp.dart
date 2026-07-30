import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_data_source_interface.dart';
import '../../domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  final AuthDataSourceInterface _dataSource;
  AuthRepoImp(this._dataSource);
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request)
  async=>await _dataSource.register(request);

  @override
  Future<ResultApi<LoginResponseEntity>> login({required String email, required String password}) => _dataSource.login(email: email, password: password);



}
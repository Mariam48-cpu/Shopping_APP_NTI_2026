import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/core/storage_helper/storage_helper_file.dart';
import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';
import 'package:shopping_app/feature/auth/domain/entities/register_request_entity.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_data_source_interface.dart';
import '../../domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  final AuthDataSourceInterface _dataSource;
  AuthRepoImp(this._dataSource);
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async =>
      await _dataSource.register(request);

  @override
  Future<ResultApi<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _dataSource.login(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        var entity = result.data;
        await serviceLocator<SecureStorageHelper>().saveSecure(
          key: AppKeys.token,
          value: entity!.token,
        );
        return Success(data: entity);
      case Error<LoginResponseEntity>():
        return Error(messageError: result.messageError);
    }
  }
}
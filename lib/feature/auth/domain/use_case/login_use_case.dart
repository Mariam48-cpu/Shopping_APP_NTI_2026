import 'package:injectable/injectable.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_repo_interface.dart';

import '../../../../core/network/result_api.dart';
import '../entities/login_response_entity.dart';

@injectable
class LoginUseCase {
  final AuthRepoInterface _repo;
  LoginUseCase(this._repo);

  Future<ResultApi<LoginResponseEntity>> call({
    required String email,
    required String password,
  }) async => await _repo.login(email: email, password: password);
}

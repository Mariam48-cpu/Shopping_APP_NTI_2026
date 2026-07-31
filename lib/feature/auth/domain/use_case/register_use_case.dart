import 'package:injectable/injectable.dart';
import 'package:shopping_app/feature/auth/domain/repo/auth_repo_interface.dart';

import '../../../../core/network/result_api.dart';
import '../entities/register_request_entity.dart';

@injectable
class RegisterUseCase {
  final AuthRepoInterface _repo;
  RegisterUseCase(this._repo);
  Future<ResultApi<String>> invoke(RegisterRequestEntity request) =>
      _repo.register(request);
}

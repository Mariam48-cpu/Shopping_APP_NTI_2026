import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_repo_interface.dart';

class AccountUseCase {
  AccountRepoInterface _repo;
  AccountUseCase(this._repo);
  Future<ResultApi<AccountEntity>> invoke() async => await _repo.getAccount();
}

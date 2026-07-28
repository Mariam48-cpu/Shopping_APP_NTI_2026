import 'dart:io';

import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/repo/account_repo_interface.dart';

class UpdateAccountUseCase {
  final AccountRepoInterface _repo;
  UpdateAccountUseCase(this._repo);
  Future<ResultApi<String>> invoke({
    required String name,
    required String phone,
    required String email,
    required String address,
    File? image,
  }) async => await _repo.updateAccount(
    name: name,
    phone: phone,
    email: email,
    address: address,
  );
}

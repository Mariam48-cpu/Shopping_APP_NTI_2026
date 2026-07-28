import 'dart:io';

import 'package:shopping_app/core/network/result_api.dart';

import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_data_source_interface.dart';

import '../../domain/repo/account_repo_interface.dart';

class AccountRepoImp implements AccountRepoInterface {
  AccountDataSourceInterface _dataSourceInterface;
  AccountRepoImp(this._dataSourceInterface);
  @override
  Future<ResultApi<AccountEntity>> getAccount() async =>
      await _dataSourceInterface.getAccount();

  @override
  Future<ResultApi<String>> updateAccount({
    required String name,
    required String phone,
    required String email,
    required String address,
    File? image,
  }) async => await _dataSourceInterface.updateAccount(
    name: name,
    phone: phone,
    email: email,
    address: address,
    image: image,
  );
}

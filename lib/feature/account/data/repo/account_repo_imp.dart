import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';

import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/repo/account_data_source_interface.dart';

import '../../domain/repo/account_repo_interface.dart';
@Injectable(as: AccountRepoInterface)
class AccountRepoImp implements AccountRepoInterface {
  final AccountDataSourceInterface _dataSourceInterface;
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
    required String currentImage,
    File? image,
  }) async => await _dataSourceInterface.updateAccount(
    name: name,
    phone: phone,
    email: email,
    address: address,
    currentImage: currentImage,
    image: image,
  );
}

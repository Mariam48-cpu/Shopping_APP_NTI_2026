import 'dart:io';

import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';

abstract interface class AccountDataSourceInterface {
  Future<ResultApi<AccountEntity>> getAccount();

  Future<ResultApi<String>> updateAccount({
    required String name,
    required String phone,
    required String email,
    required String address,
    File? image,
  });
}

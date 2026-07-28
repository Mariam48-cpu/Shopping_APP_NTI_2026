import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';

sealed class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  AccountEntity? account;
  AccountSuccess(this.account);
}

class AccountError extends AccountState {
  String ?messageError;

  AccountError(this.messageError);
}

class AccountUpdateSuccess extends AccountState {
  String? message;

  AccountUpdateSuccess(this.message);
}

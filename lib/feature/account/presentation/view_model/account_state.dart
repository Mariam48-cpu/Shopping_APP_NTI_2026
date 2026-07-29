import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';

sealed class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final AccountEntity account;

  AccountSuccess(this.account);
}

class AccountError extends AccountState {
  final String messageError;

  AccountError(this.messageError);
}
class AccountUpdateLoading extends AccountState {}
class AccountUpdateError extends AccountState {
  final String messageError;

  AccountUpdateError(this.messageError);
}

class AccountUpdateSuccess extends AccountState {
  final String message;

  AccountUpdateSuccess(this.message);
}

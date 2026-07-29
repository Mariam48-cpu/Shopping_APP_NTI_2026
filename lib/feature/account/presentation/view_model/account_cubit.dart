import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';
import 'package:shopping_app/feature/account/domain/use_case/account_use_case.dart';
import 'package:shopping_app/feature/account/presentation/view_model/account_state.dart';
import '../../domain/use_case/update_account_use_case.dart';
@injectable
class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._accountUseCase, this._updateAccountUseCase)
    : super(AccountInitial());
  final AccountUseCase _accountUseCase;
  final UpdateAccountUseCase _updateAccountUseCase;
  Future<void> intent(AccountIntent intent) async {
    switch (intent) {
      case FetchAccountIntent():
        await _fetchAccount();

      case UpdateAccountIntent():
        await _updateAccount(intent);
    }
  }

  Future<void> _fetchAccount() async {
    emit(AccountLoading());
    var result = await _accountUseCase.invoke();
    switch (result) {
      case Success<AccountEntity>():
        emit(AccountSuccess(result.data!));
      case Error<AccountEntity>():
        emit(AccountError(result.messageError!));
    }
  }


  Future<void> _updateAccount(UpdateAccountIntent intent) async {
    print("Cubit Update Called");
    emit(AccountUpdateLoading());
    print("Before Invoke");
    var result = await _updateAccountUseCase.invoke(
      name: intent.name,
      phone: intent.phone,
      email: intent.email,
      address: intent.address,
      image: intent.image,
    );
    print("After Invoke");
    print(result.runtimeType);
    print(result);
    switch (result) {
      case Success<String>():
        emit(AccountUpdateSuccess(result.data!));
      case Error<String>():
        print(result.messageError);
        emit(AccountUpdateError(result.messageError!));
    }
  }
}

sealed class AccountIntent {}

class FetchAccountIntent extends AccountIntent {}

class UpdateAccountIntent extends AccountIntent {
  String name;
  String phone;
  String email;
  String address;
  File? image;

  UpdateAccountIntent({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.image,
  });
}

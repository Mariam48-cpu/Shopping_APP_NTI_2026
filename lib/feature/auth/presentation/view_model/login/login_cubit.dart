import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/network/result_api.dart';
import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';

import '../../../domain/use_case/login_use_case.dart';
import 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());
  final LoginUseCase _loginUseCase;
  Future<void> intent(LoginIntent intent) async {
    switch (intent) {
      case LoginIntentLogin():
        _login(intent.email, intent.password);
    }
  }

  Future<void> _login(String email, String password) async {
    emit(LoginLoading());
    final result = await _loginUseCase.call(email: email, password: password);
    switch (result) {
      case Success<LoginResponseEntity>():
        emit(LoginSuccess(result.data));
      case Error<LoginResponseEntity>():
        emit(LoginError(result.messageError ?? "ERROR"));
    }
  }
}

sealed class LoginIntent {}

class LoginIntentLogin extends LoginIntent {
  LoginIntentLogin({required this.email, required this.password});
  final String email;
  final String password;
}
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/feature/auth/domain/entities/login_response_entity.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseEntity? loginResponseEntity;
  LoginSuccess(this.loginResponseEntity);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

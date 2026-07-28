import 'package:shopping_app/feature/account/domain/entity/account_entity.dart';

sealed class ResultApi<T> {}
class Loading extends ResultApi {}
class Success<T> extends ResultApi<T> {
  T? data;
  Success( {this.data});
}
class Error<T> extends ResultApi<T> {
  String? messageError;
  Error( {this.messageError});
}
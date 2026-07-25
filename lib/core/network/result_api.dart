sealed class ResultApi<T> {}

class Success<T> extends ResultApi<T> {
  final T data;

  Success({required this.data});
}

class Error<T> extends ResultApi<T> {
  final String messageError;

  Error({required this.messageError});
}
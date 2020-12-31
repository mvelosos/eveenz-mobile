abstract class Failure implements Exception {
  String get message;
}

class ConnectionError extends Failure {
  final String message;
  ConnectionError({this.message});
}

class CreateUserError extends Failure {
  final String message;
  CreateUserError({this.message});
}

class LoginError extends Failure {
  final String message;
  LoginError({this.message});
}

class LogoutError extends Failure {
  final String message;
  LogoutError({this.message});
}

class InternalError implements Failure {
  final String message;
  InternalError({this.message});
}

class RequestError implements Failure {
  final String message;
  RequestError({this.message});
}

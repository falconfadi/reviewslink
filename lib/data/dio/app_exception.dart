abstract class AppException implements Exception {
  AppException(this.message);

  String message = '';

  @override
  String toString() {
    // String result = 'FixatException';
    // return '$result: $message';
    return message;
  }
}

class WrongInputException extends AppException {
  WrongInputException({required message}) : super(message);
}

class FormSubmitFailedException extends AppException {
  FormSubmitFailedException({required message}) : super(message);
}

class LoginException extends AppException {
  LoginException({required message}) : super(message);
}

class GetException extends AppException {
  GetException({required message}) : super(message);
}

class SignupException extends AppException {
  SignupException({required message}) : super(message);
}

class RequestException extends AppException {
  RequestException({required message}) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException({required message}) : super(message);
}

class ServerException extends AppException {
  ServerException({required message}) : super(message);
}

class CategoryException extends AppException {
  CategoryException({required message}) : super(message);
}

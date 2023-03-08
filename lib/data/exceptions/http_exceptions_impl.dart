import 'package:mspr_coffee_app/data/exceptions/http_error.dart';
import 'package:mspr_coffee_app/data/exceptions/http_exception.dart';

class FetchDataException implements Exception {
  final String message;

  FetchDataException(this.message);

  factory FetchDataException.fromException(Exception exception) {
    return FetchDataException('Exception: ${exception.toString()}');
  }

  @override
  String toString() {
    return message;
  }
}

class BadRequestException extends HttpException {
  final List<HttpError> errors;

  BadRequestException(String message)
      : errors = [],
        super(message);

  BadRequestException.withErrors(this.errors) : super('Bad Request');

  factory BadRequestException.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      final errorsJson = json['errors'] as List<dynamic>;
      final errors = errorsJson.map((e) => HttpError.fromJson(e)).toList();
      return BadRequestException.withErrors(errors);
    }
    return BadRequestException(json['message'] ?? 'Bad Request');
  }
}

class UnauthorizedException extends HttpException {
  UnauthorizedException(String message) : super(message);
}

class ForbiddenException extends HttpException {
  ForbiddenException(String message) : super(message);
}

class NotFoundException extends HttpException {
  NotFoundException(String message) : super(message);
}

class InternalServerErrorException extends HttpException {
  InternalServerErrorException(String message) : super(message);
}

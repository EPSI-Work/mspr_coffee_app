import 'package:mspr_coffee_app/data/exceptions/http_error.dart';
import 'package:mspr_coffee_app/domain/exceptions/http_exception.dart';

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

  @override
  String toString() {
    return "BadRequestException: $message, errors=$errors";
  }
}

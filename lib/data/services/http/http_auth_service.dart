import 'package:mspr_coffee_app/data/services/http/http_service.dart';
import 'package:mspr_coffee_app/data/services/logger/logger_service.dart';

class HttpAuthService extends HttpService {
  @override
  final String baseUrl =
      'https://europe-west1-mspr-epsi-coffee.cloudfunctions.net/auth';
  @override
  final String version = 'v1';
  @override
  final String? xApiGateway = null;
  @override
  final String? authorizationToken = null;

  @override
  final LoggerService loggerService = LoggerService();
  HttpAuthService() : super();
}

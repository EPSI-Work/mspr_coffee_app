import 'package:mspr_coffee_app/data/services/http/http_service.dart';
import 'package:mspr_coffee_app/data/services/logger/logger_service.dart';

class HttpErpService extends HttpService {
  @override
  final String baseUrl = 'https://gateway-coffee-cpkrbolq.nw.gateway.dev';
  @override
  final String version = '';
  @override
  final String apiKey = 'C26cIff46sm';
  @override
  final String? xApiGateway = null;
  @override
  final String authorizationToken;

  @override
  final LoggerService loggerService = LoggerService();
  HttpErpService({required this.authorizationToken}) : super();

  @override
  String buildUrl(String endpoint, {String params = ''}) {
    if (baseUrl == '') {
      throw Exception('baseUrl is empty');
    }
    if (apiKey == '') {
      throw Exception('apiKey is empty');
    }
    if (version == '') {
      if (params != '') {
        return '$baseUrl/$endpoint?api_key=$apiKey&$params';
      } else {
        return '$baseUrl/$endpoint?api_key=$apiKey';
      }
    }

    if (params != '') {
      return '$baseUrl/$version/$endpoint?api_key=$apiKey&$params';
    }
    return '$baseUrl/$version/$endpoint?api_key=$apiKey';
  }
}

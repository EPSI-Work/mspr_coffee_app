import 'package:mspr_coffee_app/data/services/http/http_service.dart';

class HttpErpService extends HttpService {
  @override
  final String baseUrl = 'https://gateway-coffee-cpkrbolq.nw.gateway.dev';
  @override
  final String version = '';
  @override
  final String apiKey =
      'ewogICJpc3MiOiAiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL21zcHItZXBzaS1jb2ZmZWUiLAogICJhdWQiOiAibXNwci1lcHNpLWNvZmZlZSIsCiAgImF1dGhfdGltZSI6IDE2Nzg5NTg3MjgsCn0=';
  @override
  final String? xApiGateway = null;
  @override
  final String authorizationToken;
  HttpErpService({required this.authorizationToken}) : super();

  @override
  String buildUrl(String endpoint) {
    return '$baseUrl/$version/$endpoint?api_key=$apiKey';
  }
}

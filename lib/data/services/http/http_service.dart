import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mspr_coffee_app/data/exceptions/http_exceptions_impl.dart';
import 'package:mspr_coffee_app/data/responses/http_success_response.dart';
import 'package:mspr_coffee_app/data/services/logger/logger_service.dart';

abstract class HttpService {
  String get baseUrl;
  String get version;
  String? get xApiGateway;
  String? get authorizationToken;
  LoggerService get loggerService;

  //Url builder for the http service
  String buildUrl(String endpoint, {String params = ''}) {
    if (baseUrl == '') {
      throw Exception('baseUrl is empty');
    }
    if (version == '') {
      return '$baseUrl/$endpoint?$params';
    }

    return '$baseUrl/$version/$endpoint?$params';
  }

  Future<HttpSuccessResponse> get(
      {required String endpoint, String? params}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = "Bearer $authorizationToken!";
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
    loggerService.log('GET ${Uri.parse(buildUrl(endpoint)).toString()}');
    loggerService.log('Headers: $headers');

    final response = await http.get(
      Uri.parse(buildUrl(endpoint, params: params ?? '')),
      //Headers have to contain the authorization token if it's not null and the api key if it's not null
      headers: headers,
    );
    return _processResponse(response);
  }

  Future<HttpSuccessResponse> post(
      {required String endpoint, required dynamic body}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = "Bearer $authorizationToken!";
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
    loggerService.log('GET ${Uri.parse(buildUrl(endpoint)).toString()}');
    loggerService.log('Headers: $headers');
    loggerService.log('Body: $body');
    final response = await http.post(
      Uri.parse(buildUrl(endpoint)),
      body: json.encode(body),
      headers: headers
        ..addEntries([MapEntry('Content-Type', 'application/json')]),
    );
    return _processResponse(response);
  }

  Future<HttpSuccessResponse> put(
      {required String endpoint, required dynamic body}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = "Bearer $authorizationToken!";
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
    loggerService.log('GET ${Uri.parse(buildUrl(endpoint)).toString()}');
    loggerService.log('Headers: $headers');
    loggerService.log('Body: $body');
    final response = await http.put(
      Uri.parse(buildUrl(endpoint)),
      body: json.encode(body),
      headers: headers
        ..addEntries([MapEntry('Content-Type', 'application/json')]),
    );
    return _processResponse(response);
  }

  Future<HttpSuccessResponse> delete({required String endpoint}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = "Bearer $authorizationToken!";
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
    loggerService.log('GET ${Uri.parse(buildUrl(endpoint)).toString()}');
    loggerService.log('Headers: $headers');
    final response = await http.delete(
      Uri.parse(buildUrl(endpoint)),
      headers: headers,
    );
    return _processResponse(response);
  }

  HttpSuccessResponse _processResponse(http.Response response) {
    final responseJson = json.decode(response.body.toString());

    switch (response.statusCode) {
      case 200:
        return HttpSuccessResponse(200, content: responseJson);
      case 201:
        return HttpSuccessResponse(201, content: responseJson);
      case 400:
        loggerService.log('400');
        loggerService.log(responseJson);
        throw BadRequestException.fromJson(responseJson);
      case 401:
        loggerService.log('401');
        loggerService.log(responseJson.toString());
        throw UnauthorizedException(responseJson['message'] ?? 'Unauthorized');
      case 403:
        loggerService.log('403');
        loggerService.log(responseJson);
        throw ForbiddenException(responseJson['message'] ?? 'Forbidden');
      case 404:
        loggerService.log('404');
        loggerService.log(responseJson);
        throw NotFoundException(responseJson['message'] ?? 'Not Found');
      case 500:
        loggerService.log('500');
        loggerService.log(responseJson);
        throw InternalServerErrorException(
            responseJson['message'] ?? 'Internal Server Error');
      default:
        loggerService.log('Unknown error');
        loggerService.log(responseJson);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

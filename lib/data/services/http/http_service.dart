import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mspr_coffee_app/data/exceptions/http_exceptions_impl.dart';
import 'package:mspr_coffee_app/data/responses/http_success_response.dart';

abstract class HttpService {
  String get baseUrl;
  String get version;
  String? get xApiGateway;
  String? get authorizationToken;

  //Url builder for the http service
  String buildUrl(String endpoint) {
    return '$baseUrl/$version/$endpoint';
  }

  Future<HttpSuccessResponse> get({required String endpoint}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = authorizationToken!;
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
    final response = await http.get(
      Uri.parse(buildUrl(endpoint)),
      //Headers have to contain the authorization token if it's not null and the api key if it's not null
      headers: headers,
    );
    return _processResponse(response);
  }

  Future<HttpSuccessResponse> post(
      {required String endpoint, required dynamic body}) async {
    final headers = <String, String>{};
    if (authorizationToken != null) {
      headers['Authorization'] = authorizationToken!;
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
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
      headers['Authorization'] = authorizationToken!;
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
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
      headers['Authorization'] = authorizationToken!;
    }
    if (xApiGateway != null) {
      headers['x-apigateway-api-userinfo'] = xApiGateway!;
    }
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
        throw BadRequestException.fromJson(responseJson);
      case 401:
        throw UnauthorizedException(responseJson['message'] ?? 'Unauthorized');
      case 403:
        throw ForbiddenException(responseJson['message'] ?? 'Forbidden');
      case 404:
        throw NotFoundException(responseJson['message'] ?? 'Not Found');
      case 500:
        throw InternalServerErrorException(
            responseJson['message'] ?? 'Internal Server Error');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

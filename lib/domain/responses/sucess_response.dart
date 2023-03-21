import 'dart:convert';

class SuccessResponse<T> {
  final int statusCode;
  final dynamic content;

  SuccessResponse(this.statusCode, this.content);

  T get data => content is Map<String, dynamic>
      ? _convertToType<T>(content)
      : content as T;

  T _convertToType<T>(dynamic json) {
    if (json is Map<String, dynamic>) {
      try {
        return jsonDecode(jsonEncode(json)) as T;
      } catch (e) {
        throw Exception("Failed to convert JSON to type '$T': $e");
      }
    } else {
      throw Exception("Invalid JSON type: ${json.runtimeType}");
    }
  }

  @override
  String toString() {
    return "SuccessResponse: statusCode=$statusCode, data=$data";
  }

  String? get message =>
      (data is Map) ? (data as Map)['message'] ?? (data as Map)['msg'] : null;
}

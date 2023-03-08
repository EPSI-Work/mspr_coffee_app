class SuccessResponse {
  final int statusCode;
  final dynamic data;

  SuccessResponse(this.statusCode, this.data);

  @override
  String toString() {
    return "SuccessResponse: statusCode=$statusCode, data=$data";
  }

  String? get message => data['message'] ?? data['msg'];
}

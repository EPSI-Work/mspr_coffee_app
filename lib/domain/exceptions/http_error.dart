class HttpError {
  final String message;
  final String param;
  final String location;

  HttpError(this.message, this.param, this.location);

  factory HttpError.fromJson(Map<String, dynamic> json) {
    return HttpError(json['msg'], json['param'], json['location']);
  }

  @override
  String toString() {
    return "HttpError: message=$message, param=$param, location=$location";
  }
}

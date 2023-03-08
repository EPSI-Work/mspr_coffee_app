class HttpError {
  final String message;
  final String param;
  final String location;

  HttpError(
      {required this.message, required this.param, required this.location});

  factory HttpError.fromJson(Map<String, dynamic> json) {
    return HttpError(
      message: json['msg'],
      param: json['param'],
      location: json['location'],
    );
  }

  @override
  String toString() {
    return 'HttpError: $message [param: $param, location: $location]';
  }
}

import 'dart:convert';
import 'dart:io';

class HttpSuccessResponse<T> extends HttpResponse {
  final int statusCode;
  final dynamic content;
  final Encoding encoding;

  HttpSuccessResponse(this.statusCode, {this.content, this.encoding = utf8});

  T get responseJson => content is Map<String, dynamic>
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
    return "SuccessResponse: statusCode=$statusCode, content=$content";
  }

  @override
  void add(List<int> data) {
    // TODO: implement add
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  Future addStream(Stream<List<int>> stream) {
    // TODO: implement addStream
    throw UnimplementedError();
  }

  @override
  Future close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  Future<Socket> detachSocket({bool writeHeaders = true}) {
    // TODO: implement detachSocket
    throw UnimplementedError();
  }

  @override
  Future get done => throw UnimplementedError();

  @override
  Future flush() {
    // TODO: implement flush
    throw UnimplementedError();
  }

  @override
  HttpHeaders get headers => throw UnimplementedError();

  @override
  Future redirect(Uri location, {int status = HttpStatus.movedTemporarily}) {
    // TODO: implement redirect
    throw UnimplementedError();
  }

  @override
  void write(Object? object) {
    // TODO: implement write
  }

  @override
  void writeAll(Iterable objects, [String separator = ""]) {
    // TODO: implement writeAll
  }

  @override
  void writeCharCode(int charCode) {
    // TODO: implement writeCharCode
  }

  @override
  void writeln([Object? object = ""]) {
    // TODO: implement writeln
  }

  @override
  set encoding(Encoding _encoding) {
    // TODO: implement encoding
  }
}

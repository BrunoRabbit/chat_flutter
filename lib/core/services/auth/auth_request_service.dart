import 'package:chat_flutter/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  Future<http.Response> post({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    Object? body,
  });

   Future<http.Response> get({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  });
}

class AuthRequestService extends HttpService {
  @override
  Future<http.Response> post({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    Object? body,
  }) async {
    return await http
        .post(
      url,
      headers: headers,
      body: body,
    )
        .timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        throw const ConnectionException();
      },
    );
  }
  
  @override
  Future<http.Response> get({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    return await http.get(
      url,
      headers: headers,
    );
  }
}

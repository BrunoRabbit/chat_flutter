import 'package:http/http.dart' as http;

class AuthRequestService {
 static Future<http.Response> post({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
    Object? body,
  }) async {
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    return response;
  }

  Future<http.Response> get({
    required Uri url,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    http.Response response = await http.get(
      url,
      headers: headers,
    );

    return response;
  }
}
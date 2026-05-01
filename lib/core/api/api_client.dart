import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl = "https://localhost:7289";
Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt");
  }
  Future<http.Response> post(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    return await http.post(
      Uri.parse(baseUrl + url),
      body: body,
      headers: headers,
    );
  }

  Future<http.Response> get(String url) async {
    final token = await _getToken();

    return await http.get(
      Uri.parse('$baseUrl$url'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}


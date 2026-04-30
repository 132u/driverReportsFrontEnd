import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://localhost:7289"; 
  // ⚠️ emulator = 10.0.2.2

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );
print("STATUS: ${response.statusCode}");
  print("BODY: ${response.body}");
  final data2 = jsonDecode(response.body);
  final ddd=data2["jwtToken"];
  print("BODY: ${jsonDecode(response.body)}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["jwtToken"];
    }

    return null;
  }
}
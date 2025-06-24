import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final _storage = const FlutterSecureStorage();
  final _baseUrl = "https://spark-pretty-spirit.glitch.me";

  // Save JWT token securely
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
    print("✅ Token saved successfully");
  }

  // Retrieve stored token
  Future<String?> getToken() async {
    final token = await _storage.read(key: 'jwt_token');
    if (token != null) print("🔑 Retrieved token: $token");
    return token;
  }

  // Delete token (logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
    print("🚫 Token deleted");
  }

  // Decode and print JWT
  Future<void> printDecodedToken() async {
    final token = await getToken();
    if (token != null) {
      final decoded = JwtDecoder.decode(token);
      print("🧾 Decoded Token: $decoded");
    } else {
      print("❌ No token to decode");
    }
  }

  // Login: POST /login with email & password
  Future<String?> login(String email, String password) async {
    final url = Uri.parse("$_baseUrl/login");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      print("🔁 Login status: ${response.statusCode}");
      print("📥 Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        if (token != null) {
          await saveToken(token);
          print("✅ Logged in successfully");
          return null; // No error
        } else {
          return "❌ Token not found in response";
        }
      } else {
        return "❌ Login failed: ${response.body}";
      }
    } catch (e) {
      return "⚠️ Error: $e";
    }
  }

  // Example of a protected GET request using the stored token
  Future<String> getProtectedData() async {
    final token = await getToken();
    if (token == null) return "🔒 No token found. Please login first.";

    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/protected"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("🔁 Protected GET status: ${response.statusCode}");
      print("📥 Protected GET response: ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        return "⛔ Unauthorized. Please login again.";
      } else {
        return "⚠️ Unexpected Error: ${response.statusCode}";
      }
    } catch (e) {
      return "❌ Network Error: $e";
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Example: User Registration
  Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/api/register');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
  }

  // Example: User Login
  Future<http.Response> loginUser(Map<String, dynamic> credentials) async {
    final url = Uri.parse('$baseUrl/api/login');
    return await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );
  }

  // Example: Fetch Health Data
  Future<http.Response> fetchHealthData(String token) async {
    final url = Uri.parse('$baseUrl/api/health-data');
    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}

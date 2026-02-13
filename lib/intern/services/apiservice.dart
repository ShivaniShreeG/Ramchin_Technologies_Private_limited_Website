import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://rks2ql97-3010.inc1.devtunnels.ms';

  static Future<List<Map<String, dynamic>>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load courses');
    }
  }

  static Future<bool> createApplication({
    required String coursename,
    required String name,
    required String email,
    required String phone,
    required String createdtime,
    required String amount,
    required String payment_status,
    required String transaction_id,
    required String degree,
    required String subject,
    required String collegeName,
    required String yearOfStudy,
  }) async {
    final value={
      'coursename': coursename,
      'studentname': name,
      'degree': degree,
      'subject': subject,
      'year_of_study': yearOfStudy,
      'college_name': collegeName,
      'email': email,
      'phone': phone,
      'createdtime': createdtime,
      'amount': int.parse(amount),
      'payment_status': payment_status,
      'transaction_id': transaction_id,
    };
    print(value);
    final response = await http.post(
      Uri.parse('$baseUrl/applications'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(value),
    );
    print(response.body);
    return response.statusCode == 200 || response.statusCode == 201;
  }
}
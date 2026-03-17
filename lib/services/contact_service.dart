import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';

class ContactService {

  Future<bool> sendMessage(String name, String email, String message) async {
    final url = Uri.parse("${Utils.baseUrl}/contact/create");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "message": message}),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data["status"] == "Message sent successfully";
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

class Contact {
  final int id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
  @override
  String toString() {
    return 'Contact{name: $name, email: $email, message: $message, createdAt: $createdAt}';
  }
}

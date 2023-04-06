import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> postRequest(String id, String password) async {
      final url = Uri.parse('https://iotvase.azurewebsites.net/account/login');
      Map<String, dynamic> user = {
        "id": id,
        "password": password,
      };
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(user));
      return response;
    }
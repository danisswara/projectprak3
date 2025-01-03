import 'dart:convert';
import 'package:dio/dio.dart';

class LoginService {
  static final Dio _dio = Dio();
  static const String _baseUrl = 'http://localhost/aplikasilogin';
  static const String _login = 'cek_login.php';

  static Future<Map<String, dynamic>> fetchLoginAccount({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/$_login',
        options: Options(headers: {
          'Content-Type':
              'application/x-www-form-urlencoded', // Ensure correct content type
        }),
        data: {
          'username': username,
          'password': password,
        },
      );

      // Check if the response is not null and has the expected status
      (response);

      if (response.data != null) {
        // Check if response.data is a string or already a Map
        final Map<String, dynamic> data = response.data is String
            ? jsonDecode(response.data)
            : response.data;  // If it's already a Map, we can skip decoding
        // Check if 'status' exists in the response data and is 'success'
        if (data.containsKey('status') && data['status'] == 'success') {
          if (data['result'] != null && data['result'].isNotEmpty) {       
            // Parse the first user object from the result array
            final userData = data['result'][0];

            // Extracting user data
            final user = {
              'idLogin': userData['id_login'],
              'email': userData['email'],
              'username': userData['username'],
              'password': userData['password'],
              'role': userData['role'],
            };

            return {
              'status': true,
              'success': true,
              'user': user,
            };
          } else {
            return {
              'status': false,
              'message': 'User data not found',
            };
          }
        } else {
          return {
            'status': false,
            'message': data['message'] ?? 'Login failed',
          };
        }
      } else {
        // Handle the case where response.data is null
        return {
          'status': false,
          'message': 'Server response is null or invalid',
        };
      }
    } catch (e) {
      ('Error: $e');
      return {
        'status': false,
        'message': 'An unexpected error occurred: $e',
      };
    }
  }
}

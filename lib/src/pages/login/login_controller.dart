import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginController {
  static const apiUrl = 'https://a04b-181-188-162-155.ngrok-free.app/api/users'; // Reemplaza con la URL de tu punto de inicio de sesión

  Future<Map<String, dynamic>> login(String username, String password) async {
    final Map<String, String> bodyData = {
      'username': username,
      'password': password,
    };
    print(username);
    print(password);

    try {

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(bodyData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // En este punto, la API debería devolver un token de autenticación si el inicio de sesión es exitoso.
        final token = data['token'];


        return {
          'success': true,
          'message': 'Inicio de sesión exitoso',
          'token': token,
        };
      } else {

        final data = json.decode(response.body);
        return {

          'success': false,
          'message': 'Error de inicio de sesión: ${data['message']}',
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'Error de conexión: $e',
      };
    }
  }
}

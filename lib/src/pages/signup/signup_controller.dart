import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupController {
  static const apiUrl = 'https://a04b-181-188-162-155.ngrok-free.app/api/users'; // Reemplaza con la URL de tu servidor API

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String fechaNacimiento,
    required String ci,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'name': name,
        'email': email,
        'fecha_nacimiento': fechaNacimiento,
        'ci': ci,
        'password': password,
      },
    );
    print('1');

    if (response.statusCode == 200) {

      final data = json.decode(response.body);
      return {
        'success': true,
        'message': 'Registro exitoso',
        'user': data['usuario'],
      };

    } else {
      print('3');
      final data = json.decode(response.body);
      return {
        'success': false,
        'message': 'Error de registro: ${data['message']}',
      };
    }
  }
}

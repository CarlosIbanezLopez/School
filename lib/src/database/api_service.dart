import 'dart:convert';
import 'package:http/http.dart' as http;

import '../factorys/student_grade.dart';

class ApiService {
  static const String apiUrl = 'http://localhost:3000/data';

  Future<List<StudentGrade>> fetchGrades() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print('ssssssssssssssssssssssssssssssssssss');
      return jsonResponse.map((data) => StudentGrade.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load grades');
    }
  }
}

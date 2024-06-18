import 'package:flutter/material.dart';
import '../../database/api_service.dart';
import '../../factorys/student_grade.dart';

class StudentGradePage extends StatefulWidget {
  @override
  _StudentGradePageState createState() => _StudentGradePageState();
}

class _StudentGradePageState extends State<StudentGradePage> {
  late Future<List<StudentGrade>> futureGrades;

  @override
  void initState() {
    super.initState();
    futureGrades = ApiService().fetchGrades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Grades'),
      ),
      body: FutureBuilder<List<StudentGrade>>(
        future: futureGrades,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            List<StudentGrade> grades = snapshot.data!;
            return ListView.builder(
              itemCount: grades.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Year: ${grades[index].year} - Grade: ${grades[index].grade}'),
                  subtitle: Text('Student ID: ${grades[index].studentName} - Subject ID: ${grades[index].subjectName}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

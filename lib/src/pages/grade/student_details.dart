import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/main_button.dart';
import '../../helpers/theme_colors.dart';
import '../calendar/calendar_page.dart';
import 'data_screen.dart';

class StudentDetails extends StatefulWidget {
  final String ci;
  const StudentDetails({Key? key, required this.ci}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Future<List<dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = fetchData(widget.ci);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes del Apoderado'),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay datos disponibles'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        final name = item['name'];
                        final ci = item['ci'];

                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(name),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DataScreen(ci: ci),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            MainButton(
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CalendarPage(UserRole.viewer),
                ),
              ),
              text: 'Calendario',
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchData(String ci) async {
  final response = await http.get(Uri.parse('http://192.168.0.4:3000/tutor?email=$ci'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al cargar los datos');
  }
}

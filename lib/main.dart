import 'package:flutter/material.dart';
import 'package:school/src/helpers/theme_colors.dart';
import 'package:school/src/pages/home/start_page.dart';
import 'package:school/src/pages/my_home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School',
      theme: ThemeData(
        primaryColor: ThemeColors.primaryColor,
        scaffoldBackgroundColor: ThemeColors.scaffoldBbColor,
      ),
      home: StartPage(),
    );
  }
}

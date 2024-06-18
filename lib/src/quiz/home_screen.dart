import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/src/pages/calendar/calendar_page.dart';
import 'package:school/src/pages/grade/data_screen.dart';
import 'package:school/src/quiz/quiz_page.dart';
import 'package:school/src/quiz/review_quiz_page.dart';

import '../components/main_button.dart';
import '../game/game_screen.dart';
import '../helpers/theme_colors.dart';

class HomeScreen extends StatelessWidget {
  final String ci;
  const HomeScreen({Key? key, required this.ci}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBbColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 1),
                child: Icon(
                  Icons.wb_sunny_outlined,
                  size: 100,
                  color: Colors.purple.shade100,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: ThemeColors.textFieldBgColor,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      MainButton(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DataScreen(ci: ci),
                            )),
                        text: 'Mis notas',
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => GameScreen(),
                            )),
                        text: 'Matematicas',
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => QuizPage(),
                            )),
                        text: 'Quiz',
                      ),
                      const SizedBox(height: 20),

                      MainButton(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ReviewQuizPage(),
                            )
                        ),
                        text: 'Review',
                      ),
                      const SizedBox(height: 20),
                      MainButton(
                        onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CalendarPage(UserRole.viewer),
                            )),
                        text: 'Calendario',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

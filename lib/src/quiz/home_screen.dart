import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school/src/quiz/quiz_page.dart';
import 'package:school/src/quiz/review_quiz_page.dart';

import '../components/main_button.dart';
import '../game/game_screen.dart';
import '../helpers/theme_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBbColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child: Icon(
                Icons.wb_sunny_outlined,
                size: 100,
                color: Colors.purple.shade100,
              ),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: ThemeColors.textFieldBgColor,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  Container(

    ),

                  MainButton(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => GameScreen(),
                        )
                    ),

                    text: 'Matematicas',
                  ),

                  SizedBox(height: 20),

                  MainButton(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => QuizPage(),
                        )
                    ),
                    text: 'Quiz',
                  ),
                  SizedBox(height: 20),

                  MainButton(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ReviewQuizPage(),
                        )
                    ),
                    text: 'Review',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
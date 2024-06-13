import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/font_size.dart';
import '../helpers/theme_colors.dart';
import '../quiz_logic/quiz.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key, required this.quiz}) : super(key: key);
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBbColor,
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin:
              const EdgeInsets.only(left: 3, right: 3, top: 2, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.indigo.shade50,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Preguntas: ${quiz.questions.length}',
                      style: GoogleFonts.poppins(
                        color: ThemeColors.greyTextColor,
                        fontSize: FontSize.medium,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  Text(
                    'Correctas: ${quiz.percent}%',
                      style: GoogleFonts.poppins(
                        color: ThemeColors.greyTextColor,
                        fontSize: FontSize.medium,
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: quiz.questions.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: quiz.questions[index].correct
                          ? Colors.green.shade200
                          : Colors.red.shade200,
                      child: ListTile(
                        leading: quiz.questions[index].correct
                            ? Icon(Icons.check, color: Colors.green.shade900)
                            : Icon(Icons.close, color: Colors.red.shade900),
                        title: Text(quiz.questions[index].question),
                        subtitle: Text(quiz.questions[index].selected),
                        trailing: Text(quiz.questions[index].answer),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/font_size.dart';
import '../helpers/theme_colors.dart';
import '../quiz_logic/question.dart';
import '../quiz_logic/quiz.dart';

class ReviewQuizPage extends StatefulWidget {
  const ReviewQuizPage({Key? key}) : super(key: key);

  @override
  State<ReviewQuizPage> createState() => _ReviewQuizPageState();
}

class _ReviewQuizPageState extends State<ReviewQuizPage> {
  Quiz quiz = Quiz(name: 'Quiz de Capitales', questions: []);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/paises.json');
    final List<dynamic> data = await json.decode(response);
    for (var item in data) {
      Question question = Question.fromJson(item);
      question.question += question.country;
      quiz.questions.add(question);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.scaffoldBbColor,
        appBar: AppBar(
          backgroundColor: ThemeColors.primaryColor,
          elevation: 0,
        ),
        body: quiz.questions.isNotEmpty
            ? Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                  left: 8, right: 8, top: 2, bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                border:
                Border.all(color: ThemeColors.primaryColor, width: 1),
              ),
              child: Center(
                child: Text(
                  "Preguntas: ${quiz.questions.length}",
                    style: GoogleFonts.poppins(
                      color: ThemeColors.greyTextColor,
                      fontSize: FontSize.medium,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: quiz.questions.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: ThemeColors.primaryColor,
                      child: ListTile(
                        leading: Text("${index + 1}"),
                        title: Text(quiz.questions[index].question),
                        trailing: Text(quiz.questions[index].answer),
                      ),
                    );
                  }),
            ),
          ],
        )
            : const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
  }
}
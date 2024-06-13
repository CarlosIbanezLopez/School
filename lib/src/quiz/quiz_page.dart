import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school/src/quiz/results.dart';

import '../helpers/font_size.dart';
import '../helpers/theme_colors.dart';
import '../quiz_logic/question.dart';
import '../quiz_logic/quiz.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int totalQuestions = 5;
  int totalOptions = 4;
  int questionIndex = 0;
  int progressIndex = 0;
  Quiz quiz = Quiz(name: 'Quiz de Capitales', questions: []);

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/paises.json');
    final List<dynamic> data = await json.decode(response);
    List<int> optionList = List<int>.generate(data.length, (i) => i);
    List<int> questionsAdded = [];

    while (true) {
      optionList.shuffle();
      int answer = optionList[0];
      if (questionsAdded.contains(answer)) continue;
      questionsAdded.add(answer);

      List<String> otherOptions = [];
      for (var option in optionList.sublist(1, totalOptions)) {
        otherOptions.add(data[option]['capital']);
      }

      Question question = Question.fromJson(data[answer]);
      question.addOptions(otherOptions);
      quiz.questions.add(question);

      if (quiz.questions.length >= totalQuestions) break;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void _optionSelected(String selected) {
    quiz.questions[questionIndex].selected = selected;
    if (selected == quiz.questions[questionIndex].answer) {
      quiz.questions[questionIndex].correct = true;
      quiz.right += 1;
    }

    progressIndex += 1;
    if (questionIndex < totalQuestions - 1) {
      questionIndex += 1;
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildResultDialog(context));
    }

    setState(() {});
  }

  Widget _buildResultDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Resultados', style: GoogleFonts.poppins(
        color: ThemeColors.whiteTextColor,
        fontSize: FontSize.medium,
        fontWeight: FontWeight.w600,
      )),
      backgroundColor: ThemeColors.scaffoldBbColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preguntas totales: $totalQuestions',
              style: GoogleFonts.poppins(
                color: ThemeColors.greyTextColor,
                fontSize: FontSize.medium,
                fontWeight: FontWeight.w600,
              )
          ),
          Text(
            'Correctas: ${quiz.right}',
              style: GoogleFonts.poppins(
                color: ThemeColors.greyTextColor,
                fontSize: FontSize.medium,
                fontWeight: FontWeight.w600,
              )
          ),
          Text(
            'Incorrectas: ${(totalQuestions - quiz.right)}',
              style: GoogleFonts.poppins(
                color: ThemeColors.greyTextColor,
                fontSize: FontSize.medium,
                fontWeight: FontWeight.w600,
              )
          ),
          Text(
            'Porcentaje: ${quiz.percent}%',
              style: GoogleFonts.poppins(
                color: ThemeColors.greyTextColor,
                fontSize: FontSize.medium,
                fontWeight: FontWeight.w600,
              )
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => ResultsPage(
                    quiz: quiz,
                  ))),
            );
          },
          child: Text(
            'Ver Respuestas',
          style: GoogleFonts.poppins(
    color: ThemeColors.primaryColor,
    fontSize: FontSize.medium,
    fontWeight: FontWeight.w600,
          )
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.scaffoldBbColor,
      appBar: AppBar(
        title: Text(quiz.name),
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                color: Colors.green,
                value: progressIndex / totalQuestions,
                minHeight: 20,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: quiz.questions.isNotEmpty
                  ? Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Text(
                        quiz.questions[questionIndex].question,
                          style: GoogleFonts.poppins(
                            color: ThemeColors.greyTextColor,
                            fontSize: FontSize.medium,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: totalOptions,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: ThemeColors.primaryColor,
                              border: Border.all(
                                  color: Colors.indigo.shade100,
                                  width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              leading: Text('${index + 1}',
                                  style: GoogleFonts.poppins(
                                    color: ThemeColors.greyTextColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w600,
                                  )),
                              title: Text(
                                  quiz.questions[questionIndex]
                                      .options[index],
                                  style: GoogleFonts.poppins(
                                    color: ThemeColors.greyTextColor,
                                    fontSize: FontSize.medium,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onTap: () {
                                _optionSelected(quiz
                                    .questions[questionIndex]
                                    .options[index]);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
                  : const CircularProgressIndicator(
                backgroundColor: ThemeColors.textFieldHintColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _optionSelected('Skipped');
            },
            child: Text('Skip', style: GoogleFonts.poppins(
              color: ThemeColors.greyTextColor,
              fontSize: FontSize.medium,
              fontWeight: FontWeight.w600,
            )),
          ),
        ],
      ),
    );
  }
}
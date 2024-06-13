import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:school/src/helpers/theme_colors.dart';

import '../components/main_button.dart';
import '../helpers/font_size.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController _controller = TextEditingController();
  final Random _random = Random();
  int _score = 0;
  String _question = '';
  late int _correctAnswer;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    int num1 = _random.nextInt(10) + 1;
    int num2 = _random.nextInt(10) + 1;
    String operator;
    switch (_random.nextInt(4)) {
      case 0:
        operator = '+';
        _correctAnswer = num1 + num2;
        break;
      case 1:
        operator = '-';
        _correctAnswer = num1 - num2;
        break;
      case 2:
        operator = '*';
        _correctAnswer = num1 * num2;
        break;
      case 3:
        operator = '/';
        num2 = _random.nextInt(9) + 1; // Avoid division by 0
        _correctAnswer = (num1 / num2).floor();
        break;
      default:
        operator = '+';
        _correctAnswer = num1 + num2;
    }
    setState(() {
      _question = '$num1 $operator $num2';
    });
  }

  void _checkAnswer() {
    int userAnswer = int.parse(_controller.text);
    if (userAnswer == _correctAnswer) {
      setState(() {
        _score++;
      });
    } else {
      setState(() {
        _score--;
      });
    }
    _controller.clear();
    _generateQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego de Operaciones Matemáticas'),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Puntuación: $_score',
          style: GoogleFonts.poppins(
            color: ThemeColors.whiteTextColor,
            fontSize: FontSize.xxLarge,
            fontWeight: FontWeight.w600,
          ),
            ),



            SizedBox(height: 20),
            Text(
              'Resuelve: $_question',
              style: GoogleFonts.poppins(
                color: ThemeColors.whiteTextColor,
                fontSize: FontSize.xxxLarge,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tu respuesta'),
              style: GoogleFonts.poppins(
                color: ThemeColors.whiteTextColor,
              ),
            ),
            SizedBox(height: 20),

            MainButton(
              text: 'Comprobar',
              backgroundColor: ThemeColors.primaryColor,
              onTap: _checkAnswer,
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';



class GameLogic {
  String currentQuestion = "";
  String correctAnswer = "";
  late int userScore;

  GameLogic() {
    userScore = 0;
    generateQuestion();
  }

  Future<void> generateQuestion() async {
    // Generar una pregunta aleatoria usando la IA
    final aiResponse = await fetchAIResponse('Generate a trivia question');

    currentQuestion = aiResponse['choices'][0]['text'].trim();
    print('asdfd');

    // Generar una respuesta correcta aleatoria
    final random = Random();
    correctAnswer = String.fromCharCode(random.nextInt(26) + 65);
  }

  bool checkAnswer(String userAnswer) {
    if (userAnswer.trim().toUpperCase() == correctAnswer.toUpperCase()) {
      userScore++;
      return true;
    } else {
      return false;
    }
  }
}

Future<Map<String, dynamic>> fetchAIResponse(String prompt) async {
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/engines/davinci-codex/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'sk-proj-rjuZpPBTWX7FVPh0KuxoT3BlbkFJRastei5W96Q9hjcjtfAi',
    },
    body: jsonEncode({
      'prompt': prompt,
      'max_tokens': 150,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch AI response');
  }
}
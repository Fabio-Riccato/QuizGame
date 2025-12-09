import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/trivia_question.dart';

class TriviaApiService {
  static const String _baseUrl = 'https://opentdb.com/api.php';

  Future<List<TriviaQuestion>> fetchQuestions({
    required int amount,
    required String difficulty,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl?amount=$amount&type=multiple&difficulty=$difficulty&encode=url3986',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Errore di rete');
    }

    final data = json.decode(response.body);
    if (data['response_code'] != 0) {
      throw Exception('Errore API');
    }

    final results = data['results'] as List<dynamic>;

    return results
        .map((e) => TriviaQuestion.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

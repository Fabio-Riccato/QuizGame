class TriviaQuestion {
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> allAnswers;
  final String difficulty;

  TriviaQuestion({
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.allAnswers,
    required this.difficulty,
  });

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) {
    final correct = Uri.decodeComponent(json['correct_answer'] as String);
    final incorrect = (json['incorrect_answers'] as List)
        .map((e) => Uri.decodeComponent(e as String))
        .toList();

    final question = Uri.decodeComponent(json['question'] as String);
    final category = Uri.decodeComponent(json['category'] as String);
    final difficulty = Uri.decodeComponent(json['difficulty'] as String);

    final all = [...incorrect, correct]..shuffle();

    return TriviaQuestion(
      category: category,
      question: question,
      correctAnswer: correct,
      allAnswers: all,
      difficulty: difficulty,
    );
  }
}
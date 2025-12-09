import 'package:flutter/material.dart';
import '../models/trivia_question.dart';
import '../services/trivia_api_service.dart';
import 'result.dart';

class Quiz extends StatefulWidget {
  final String difficulty; 

  const Quiz({super.key, required this.difficulty});

  @override
  State<Quiz> createState() => _QuizTabState();
}

class _QuizTabState extends State<Quiz> with AutomaticKeepAliveClientMixin {
  final TriviaApiService _api = TriviaApiService();

  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<TriviaQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedAnswer;
  bool _showFeedback = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _currentIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _showFeedback = false;
    });

    try {
      final questions = await _api.fetchQuestions(
        amount: 10,                        
        difficulty: widget.difficulty,     
      );

      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onAnswerSelected(String answer) {
    if (_showFeedback) return;

    final current = _questions[_currentIndex];
    final isCorrect = answer == current.correctAnswer;

    setState(() {
      _selectedAnswer = answer;
      _showFeedback = true;
      if (isCorrect) _score++;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _showFeedback = false;
        });
      } else {
        Navigator.pushNamed(
          context,
          Result.routeName,
          arguments: {
            'score': _score,
            'total': _questions.length,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline),
            Text(_errorMessage),
            ElevatedButton(onPressed: _loadQuestions, child: const Text("Riprova")),
          ],
        ),
      );
    }

    final current = _questions[_currentIndex];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(current.question, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: current.allAnswers.map((answer) {
                final isSelected = answer == _selectedAnswer;
                final isCorrect = answer == current.correctAnswer;

                Color? color;
                if (_showFeedback && isSelected && isCorrect) {
                  color = Colors.green;
                } else if (_showFeedback && isSelected) {
                  color = Colors.red;
                } else if (_showFeedback && isCorrect) {
                  color = Colors.green;
                }

                return Card(
                  color: color,
                  child: ListTile(
                    title: Text(answer),
                    onTap: () => _onAnswerSelected(answer),
                  ),
                );
              }).toList(),
            ),
          ),

          Text("Punteggio: $_score"),
          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _loadQuestions,
            child: const Text("Ricomincia"),
          ),
        ],
      ),
    );
  }
}

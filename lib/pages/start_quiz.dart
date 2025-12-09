import 'package:flutter/material.dart';
import 'quiz.dart';

class StartQuizPage extends StatefulWidget {
  const StartQuizPage({super.key});

  @override
  State<StartQuizPage> createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {
  String _difficulty = "easy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Seleziona difficoltà")),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text(
              "Scegli la difficoltà:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Difficoltà",
              ),
              initialValue: _difficulty,
              items: const [
                DropdownMenuItem(value: "easy", child: Text("Facile")),
                DropdownMenuItem(value: "medium", child: Text("Media")),
                DropdownMenuItem(value: "hard", child: Text("Difficile")),
              ],
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Quiz(difficulty: _difficulty),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text("Inizia il Quiz", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

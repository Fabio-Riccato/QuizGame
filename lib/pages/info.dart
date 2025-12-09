import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Info",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Questo è un semplice gioco di Quiz che usa l'API OpenTriviaDB.\n\n"
              "- Rispondi alle domande.\n"
              "- Ottieni un punto per ogni risposta corretta.\n"
              "- Alla fine vedi il punteggio.\n\n",
            ),
          ],
        ),
      ),
    );
  }
}
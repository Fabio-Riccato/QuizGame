import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  static const routeName = '/result';

  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int score = args['score'];
    final int total = args['total'];

    return Scaffold(
      appBar: AppBar(title: const Text("Risultato")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hai ottenuto:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "$score / $total",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Torna alla Home"),
            ),
          ],
        ),
      ),
    );
  }
}

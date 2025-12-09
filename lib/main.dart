import 'package:flutter/material.dart';

import 'pages/info.dart';
import 'pages/result.dart';
import 'pages/start_quiz.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz OpenTrivia',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, 
        colorSchemeSeed: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeTabsPage(),
        Result.routeName: (context) => const Result(),
      },
    );
  }
}

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  String _selectedDifficulty = 'easy';


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white, 
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Quiz OpenTrivia'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: DropdownButtonFormField<String>(
                    
                    decoration: const InputDecoration(
                      labelText: "Difficoltà",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _selectedDifficulty,
                    items: const [
                      DropdownMenuItem(value: "easy", child: Text("Facile")),
                      DropdownMenuItem(value: "medium", child: Text("Media")),
                      DropdownMenuItem(value: "hard", child: Text("Difficile")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedDifficulty = value!;
                      });
                    },
                  ),
                ),

                const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.question_mark), text: 'Quiz'),
                    Tab(icon: Icon(Icons.info_outline), text: 'Info'),
                  ],
                ),
              ],
            ),
          ),
        ),

        body: TabBarView(
          children: [
            const StartQuizPage(),
            const Info(),
          ],
        ),
      ),
    );
  }
}


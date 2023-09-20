import 'package:flutter/material.dart';

import 'package:quiz/presentation/question_and_options.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: const Column(
        children: [
          QuestionAndOptions(),
        ],
      ),
    );
  }
}

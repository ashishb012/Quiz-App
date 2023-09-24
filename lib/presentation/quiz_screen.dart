import 'package:flutter/material.dart';

import 'package:quiz/services/model/sample_data.dart';

import 'package:quiz/presentation/question_and_options.dart';

class QuizScreen extends StatefulWidget {
  final int code;

  const QuizScreen({super.key, required this.code});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final int quizCode = widget.code;
  final int noOfQ = sampleQuiz.questions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sampleQuiz.name),
      ),
      body: QuestionAndOptions(questions: sampleQuiz.questions),
    );
  }
}

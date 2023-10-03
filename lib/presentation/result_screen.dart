import 'package:flutter/material.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

class ResultScreen extends StatefulWidget {
  final Map<int, int> selectedOptions;
  final CloudQuiz quiz;
  const ResultScreen(
      {super.key, required this.selectedOptions, required this.quiz});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final Map<int, int> selectedOptions;
  late final List<CloudQuestions> questions;
  late final int totalQuestions;
  late final Map<int, bool> answers;
  int marks = 0;
  double percentage = 0;

  @override
  void initState() {
    selectedOptions = widget.selectedOptions;
    questions = widget.quiz.questions;
    totalQuestions = questions.length;
    answers = {};
    _calculateResult();
    super.initState();
  }

  void _calculateResult() {
    for (int i = 0; i < totalQuestions; i++) {
      if (questions[i].answerIndex == selectedOptions[i]) {
        answers[i] = true;
        marks++;
      } else {
        answers[i] = false;
      }
    }
    percentage = (marks / totalQuestions) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text("$answers $marks"),
              Card(
                elevation: 5.0,
                child: ListTile(
                  title: Center(
                    child: Text(
                      "Marks obtained \n$marks/$totalQuestions \nPercentage $percentage%",
                    ),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 0.0,
                  maxHeight: 500,
                ),
                child: Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: totalQuestions,
                    itemBuilder: (context, int index) {
                      final currentQuestion = questions[index];
                      final question = currentQuestion.question;
                      final yourAnswer =
                          currentQuestion.options[selectedOptions[index]!];
                      final currectAnswer =
                          currentQuestion.options[currentQuestion.answerIndex];
                      return ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text("$question \n"),
                        subtitle: Text(
                          "Correct answer: $currectAnswer \nYour answer: $yourAnswer",
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Text("Congragulations"),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quiz/presentation/quiz_screen.dart';
import 'package:quiz/routes/routes.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

class QuizListView extends StatelessWidget {
  final Iterable<CloudQuiz> quizzes;

  const QuizListView({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final quiz = quizzes.elementAt(index);
        return ListTile(
          title: Text(quiz.name),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuizScreen(quiz: quiz),
            ));
          },
        );
      },
    );
  }
}

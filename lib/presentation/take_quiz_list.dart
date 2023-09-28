import 'package:flutter/material.dart';
import 'package:quiz/presentation/quiz_list_view.dart';

import 'package:quiz/services/cloud/cloud_quiz.dart';
import 'package:quiz/services/cloud/firebase_firestore_storage.dart';

class TakeQuiz extends StatefulWidget {
  const TakeQuiz({super.key});

  @override
  State<TakeQuiz> createState() => _TakeQuizState();
}

class _TakeQuizState extends State<TakeQuiz> {
  late final FirebaseCloudStorage cloudStorage;
  List<CloudQuiz> quizList = [];

  @override
  void initState() {
    cloudStorage = FirebaseCloudStorage();
    fetchQuizzes();
    super.initState();
  }

  @override
  void dispose() {
    quizList;
    super.dispose();
  }

  Future<void> fetchQuizzes() async {
    final quizzes = await cloudStorage.getAllQuizzes();
    setState(() {
      quizList = quizzes.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quizzes"),
      ),
      body: StreamBuilder(
        stream: cloudStorage.allQuizzes(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allQuizzes = snapshot.data as Iterable<CloudQuiz>;
                return QuizListView(quizzes: allQuizzes);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

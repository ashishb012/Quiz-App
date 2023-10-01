import 'package:flutter/material.dart';
import 'package:quiz/presentation/helpers/error_snackbar.dart';
import 'package:quiz/presentation/quiz_screen.dart';

import 'package:quiz/services/cloud/cloud_quiz.dart';
import 'package:quiz/services/cloud/firebase_firestore_storage.dart';

class JoinQuizWithCode extends StatefulWidget {
  const JoinQuizWithCode({super.key});

  @override
  State<JoinQuizWithCode> createState() => _JoinQuizWithCodeState();
}

class _JoinQuizWithCodeState extends State<JoinQuizWithCode> {
  late final FirebaseCloudStorage _cloudStorage;
  late final CloudQuiz? quiz;

  late final TextEditingController _quizCode;

  @override
  void initState() {
    _cloudStorage = FirebaseCloudStorage();
    _quizCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _quizCode.dispose();
    super.dispose();
  }

  void _getQuizFromCode() async {
    final codeText = _quizCode.text;
    if (codeText.isNotEmpty) {
      final int code = int.tryParse(codeText) ?? 0;
      try {
        quiz = await _cloudStorage.getQuiz(code);
        _jionQuiz(quiz);
      } catch (e) {
        // throw Exception();
        _displayError("Invalid quiz code");
      }
    } else {
      _displayError("Please enter quiz code");
    }
    _quizCode.clear();
    _dismisKeyboard();
  }

  void _jionQuiz(CloudQuiz? quiz) {
    if (quiz != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => QuizScreen(quiz: quiz),
      ));
    } else {
      _displayError("Invalid quiz code");
    }
  }

  void _displayError(String errMsg) {
    showErrorDailog(context, errMsg);
  }

  void _dismisKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _quizCode,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration:
                  const InputDecoration(labelText: "Enter the quiz code"),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getQuizFromCode,
              child: const Text("Join Quiz"),
            ),
          ],
        ),
      ),
    );
  }
}

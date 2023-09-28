import 'package:flutter/material.dart';
import 'package:quiz/services/cloud/firebase_firestore_storage.dart';

import 'package:quiz/services/model/sample_data.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  late final FirebaseCloudStorage cloudStorage;

  @override
  void initState() {
    cloudStorage = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Quiz"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              try {
                await cloudStorage.createNewQuiz(sampleQuiz2);
              } catch (e) {
                throw Exception();
              }
            },
            child: const Text("create quiz"),
          ),
        ));
  }
}

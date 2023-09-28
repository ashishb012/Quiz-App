import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class CloudQuestions {
  final String question;
  final List<String> options;
  final int answerIndex;

  const CloudQuestions({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  CloudQuestions.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : answerIndex = snapshot.data()['answerIndex'] as int,
        options = (snapshot.data()['options'] as List<dynamic>)
            .map((option) => option as String)
            .toList(),
        question = snapshot.data()['question'] as String;

  CloudQuestions.fromMap(Map<String, dynamic> map)
      : question = map['question'] ?? '',
        options = List<String>.from(map['options'] ?? []),
        answerIndex = map['answerIndex'] ?? 0;
}

@immutable
class CloudQuiz {
  final int code;
  final String name;
  final List<CloudQuestions> questions;
  final bool isPublic;

  const CloudQuiz({
    required this.code,
    required this.name,
    required this.questions,
    required this.isPublic,
  });

  CloudQuiz.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : code = snapshot.data()['code'] as int,
        isPublic = snapshot.data()['isPublic'] as bool,
        name = snapshot.data()['name'] as String,
        questions = (snapshot.data()['questions'] as List<dynamic>)
            .map((questionData) => CloudQuestions.fromSnapshot(questionData))
            .toList();

  CloudQuiz.fromMap(Map<String, dynamic> map)
      : code = map['code'] ?? 0,
        name = map['name'] ?? '',
        questions = List<CloudQuestions>.from((map['questions'] ?? [])
            .map((question) => CloudQuestions.fromMap(question ?? {}))),
        isPublic = map['isPublic'] ?? false;
}

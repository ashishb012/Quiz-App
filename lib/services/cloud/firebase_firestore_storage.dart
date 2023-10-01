import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

class FirebaseCloudStorage {
  // singelton class
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  final firestore = FirebaseFirestore.instance.collection("Quizzes");

  Future<CloudQuiz?> getQuiz(int code) async {
    try {
      final querySnapshot =
          await firestore.where("code", isEqualTo: code).get();
      // if (querySnapshot.docs.isNotEmpty) {
      return CloudQuiz.fromMap(querySnapshot.docs.first.data());
      // } else {
      //   return null;
      // }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> createNewQuiz(CloudQuiz quiz) async {
    try {
      final List<Map<String, dynamic>> questionsList =
          quiz.questions.map((question) {
        return {
          'question': question.question,
          'options': question.options,
          'answerIndex': question.answerIndex,
        };
      }).toList();

      await firestore.add({
        "code": quiz.code,
        "name": quiz.name,
        "questions": questionsList,
        "isPublic": quiz.isPublic,
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<Iterable<CloudQuiz>> getAllQuizzes() async {
    try {
      return await firestore
          .where(
            "isPublic",
            isEqualTo: true,
          )
          .get()
          .then(
            (value) => value.docs.map((quiz) => CloudQuiz.fromMap(quiz.data())),
          );
      // return await firestore
      //     .where(
      //       "isPublic",
      //       isEqualTo: true,
      //     )
      //     .get()
      //     .then(
      //       (value) => value.docs.map((quiz) => CloudQuiz.fromSnapshot(quiz)),
      //     );
    } catch (e) {
      //Todo : Custom exception
      throw Exception();
    }
  }

  Stream<Iterable<CloudQuiz>> allQuizzes() =>
      firestore.where("isPublic", isEqualTo: true).snapshots().map(
            (event) => event.docs.map((doc) => CloudQuiz.fromMap(doc.data())),
          );
  // firestore.where("isPublic", isEqualTo: true).snapshots().map(
  //       (event) => event.docs.map((doc) => CloudQuiz.fromSnapshot(doc)),
  //     );
}

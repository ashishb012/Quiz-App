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
      if (querySnapshot.docs.isNotEmpty) {
        return CloudQuiz.fromSnapshot(querySnapshot.docs.first);
      } else {
        return null;
      }
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


// class FirebaseCloudStorage {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<Quiz> getQuiz(int code) async {
//     try {
//       final quizDoc =
//           await firestore.collection("Quizes").doc(code.toString()).get();
//       final quizData = quizDoc.data();
//       final List<Questions> questions = await Future.wait(
//         quizData!["questions"].map(
//           (question) async {
//             final questionsDoc = question.get();
//             final questionData = questionsDoc.data();
//             return Questions(
//               id: questionData["id"],
//               question: questionData["question"],
//               options:
//                   (questionData["options"] as List<dynamic>).cast<String>(),
//               answerIndex: questionData["answerIndex"],
//             );
//           },
//         ),
//       );
//       return Quiz(
//         code: quizData["code"],
//         name: quizData["name"],
//         questions: questions,
//       );
//     } catch (e) {
//       // TODO Custom exceptions;
//       throw Exception();
//     }
//   }

//   Future<void> createQuiz(Quiz quiz) async {
//     final quizDoc = firestore.collection("Quizes").doc(quiz.code.toString());
//     final List<Map<String, dynamic>> questionsList =
//         quiz.questions.map((question) {
//       return {
//         'id': question.id,
//         'question': question.question,
//         'options': question.options,
//         'answerIndex': question.answerIndex,
//       };
//     }).toList();
//     await quizDoc.set({
//       "code": quiz.code,
//       "name": quiz.name,
//       "questions": questionsList,
//     });
//   }
// }

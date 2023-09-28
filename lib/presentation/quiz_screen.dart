import 'package:flutter/material.dart';
import 'package:quiz/services/cloud/firebase_firestore_storage.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

// import 'package:quiz/services/model/sample_data.dart';

import 'package:quiz/presentation/question_and_options.dart';

class QuizScreen extends StatefulWidget {
  final CloudQuiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final FirebaseCloudStorage cloudStorage;
  late final CloudQuiz quiz;

  @override
  void initState() {
    quiz = widget.quiz;
    cloudStorage = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name),
      ),
      body: QuestionAndOptions(questions: quiz.questions),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.done),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:quiz/services/model/questions_model.dart';

// import 'package:quiz/services/model/sample_data.dart';

// class QuizScreen extends StatefulWidget {
//   final int code;

//   const QuizScreen({super.key, required this.code});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   late final int quizCode;
//   late final List<Questions> questions;
//   Map<int, int?> selectedOptions = {};
//   // final int noOfQ = sampleQuiz.questions.length;

//   @override
//   void initState() {
//     quizCode = widget.code;
//     questions = sampleQuiz1.questions;
//     for (int i = 0; i < questions.length; i++) {
//       selectedOptions[i] = -1;
//     }
//     super.initState();
//   }

//   @override
//   void dispose() {
//     quizCode;
//     questions;
//     selectedOptions;
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(sampleQuiz1.name),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(bottom: 60.0),
//         child: ListView.builder(
//           itemCount: questions.length,
//           itemBuilder: (BuildContext context, int index) {
//             final question = questions[index];
//             return Card(
//               margin: const EdgeInsets.all(10.0),
//               elevation: 4.0,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       title: Text(
//                         "Q ${index + 1}. ${question.question} ",
//                       ),
//                     ),
//                     // const SizedBox(height: 18.0),
//                     Container(
//                       alignment: AlignmentDirectional.centerEnd,
//                       child: TextButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedOptions[index] = -1;
//                           });
//                         },
//                         child: const Text("remove selection"),
//                       ),
//                     ),
//                     // const SizedBox(height: 18.0),
//                     Column(
//                       children: question.options
//                           .asMap()
//                           .entries
//                           .map(
//                             (option) => GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedOptions[index] = option.key;
//                                   print(selectedOptions);
//                                 });
//                               },
//                               child: Container(
//                                 color: _selectedColor(
//                                     selectedOptions[index], option.key),
//                                 child: ListTile(
//                                   title: Text(option.value),
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: FloatingActionButton(
//           onPressed: () {},
//           child: const Icon(Icons.done),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   Color _selectedColor(int? a, int b) {
//     if (a == null) {
//       return Colors.transparent;
//     }
//     if (a == b) {
//       return Colors.blueAccent;
//     } else {
//       return Colors.transparent;
//     }
//   }
// }

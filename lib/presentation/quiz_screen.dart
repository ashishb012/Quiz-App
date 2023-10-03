import 'package:flutter/material.dart';
import 'package:quiz/presentation/helpers/error_snackbar.dart';
import 'package:quiz/presentation/result_screen.dart';

import 'package:quiz/services/cloud/firebase_firestore_storage.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

class QuizScreen extends StatefulWidget {
  final CloudQuiz quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final FirebaseCloudStorage cloudStorage;
  late final CloudQuiz quiz;
  late final int totalQuestions;
  late Map<int, int> selectedOptions = {};
  int currentQuestionIndex = 0;
  DateTime? _lastPressed;

  @override
  void initState() {
    cloudStorage = FirebaseCloudStorage();
    quiz = widget.quiz;
    totalQuestions = quiz.questions.length;
    for (int i = 0; i < totalQuestions; i++) {
      selectedOptions[i] = -1;
    }
    super.initState();
  }

  void submitQuiz() {
    bool notAnswered = false;
    for (int i = 0; i < totalQuestions; i++) {
      if (selectedOptions[i] == -1) {
        notAnswered = true;
        break;
      }
    }
    if (notAnswered) {
      showErrorDailog(
        context,
        "Please answer all the questions before submitting the quiz",
      );
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ResultScreen(
          selectedOptions: selectedOptions,
          quiz: quiz,
        ),
      ));
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      showErrorDailog(context, 'Press back again to exit.');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final question = quiz.questions[currentQuestionIndex];
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(quiz.name),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Card(
                margin: const EdgeInsets.all(10.0),
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "Q ${currentQuestionIndex + 1}. ${question.question} ",
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedOptions[currentQuestionIndex] = -1;
                            });
                          },
                          child: const Text("remove selection"),
                        ),
                      ),
                      Column(
                        children: question.options
                            .asMap()
                            .entries
                            .map(
                              (option) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOptions[currentQuestionIndex] =
                                        option.key;
                                  });
                                },
                                child: Container(
                                  color: _selectedColor(
                                      selectedOptions[currentQuestionIndex],
                                      option.key),
                                  child: ListTile(
                                    title: Text(option.value),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  if (currentQuestionIndex != 0)
                    ElevatedButton(
                      onPressed: goToPreviousQuestion,
                      child: const Text('Previous'),
                    ),
                  const Spacer(),
                  if (currentQuestionIndex < quiz.questions.length - 1)
                    ElevatedButton(
                      onPressed: goToNextQuestion,
                      child: const Text('Next'),
                    ),
                ],
              ),
            ),
            const Spacer(),
            if (currentQuestionIndex == totalQuestions - 1)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => submitQuiz(),
                  child: const Text("Submit Quiz"),
                ),
              ),
          ],
        ),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.done),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Color _selectedColor(int? selectedOption, int optionIndex) {
    if (selectedOption == null) {
      return Colors.transparent;
    }
    if (selectedOption == optionIndex) {
      return Colors.blueAccent;
    } else {
      return Colors.transparent;
    }
  }
}


// // Old Quiz Screen (all question in a list)

// import 'package:flutter/material.dart';

// import 'package:quiz/services/cloud/firebase_firestore_storage.dart';
// import 'package:quiz/services/cloud/cloud_quiz.dart';

// import 'package:quiz/presentation/question_and_options.dart';

// class QuizScreen extends StatefulWidget {
//   final CloudQuiz quiz;

//   const QuizScreen({super.key, required this.quiz});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   late final FirebaseCloudStorage cloudStorage;
//   late final CloudQuiz quiz;

//   @override
//   void initState() {
//     quiz = widget.quiz;
//     cloudStorage = FirebaseCloudStorage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(quiz.name),
//       ),
//       body: QuestionAndOptions(questions: quiz.questions),
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
// }

// // question_and_options.dart
// import 'package:flutter/material.dart';

// import 'package:quiz/services/cloud/cloud_quiz.dart';

// class QuestionAndOptions extends StatefulWidget {
//   final List<CloudQuestions> questions;
//   const QuestionAndOptions({super.key, required this.questions});

//   @override
//   State<QuestionAndOptions> createState() => _QuestionAndOptionsState();
// }

// class _QuestionAndOptionsState extends State<QuestionAndOptions> {
//   late final List<CloudQuestions> questions;
//   late Map<int, int?> selectedOptions = {};
//   @override
//   void initState() {
//     questions = widget.questions;
//     for (int i = 0; i < questions.length; i++) {
//       selectedOptions[i] = -1;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 60.0),
//       child: ListView.builder(
//         itemCount: questions.length,
//         itemBuilder: (BuildContext context, int index) {
//           final question = questions[index];
//           return Card(
//             margin: const EdgeInsets.all(10.0),
//             elevation: 10.0,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     title: Text(
//                       "Q ${index + 1}. ${question.question} ",
//                     ),
//                   ),
//                   // const SizedBox(height: 18.0),
//                   Container(
//                     alignment: AlignmentDirectional.centerEnd,
//                     child: TextButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedOptions[index] = -1;
//                         });
//                       },
//                       child: const Text("remove selection"),
//                     ),
//                   ),
//                   // const SizedBox(height: 18.0),
//                   Column(
//                     children: question.options
//                         .asMap()
//                         .entries
//                         .map(
//                           (option) => GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 selectedOptions[index] = option.key;
//                                 // print(selectedOptions);
//                               });
//                             },
//                             child: Container(
//                               color: _selectedColor(
//                                   selectedOptions[index], option.key),
//                               child: ListTile(
//                                 title: Text(option.value),
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Color _selectedColor(int? selectedOption, int optionIndex) {
//     if (selectedOption == null) {
//       return Colors.transparent;
//     }
//     if (selectedOption == optionIndex) {
//       return Colors.blueAccent;
//     } else {
//       return Colors.transparent;
//     }
//   }
// }


//                    question.options
//                       .asMap()
//                       .entries
//                       .map(
//                         (option) => RadioListTile<int>(
//                           title: Text(option.value),
//                           value: option.key,
//                           activeColor: Colors.greenAccent,
//                           groupValue: selectedOptions[index],
//                           onChanged: (int? value) {
//                             setState(() {
//                               selectedOptions[index] = value;
//                             });
//                           },
//                         ),
//                       )
//                       .toList(),


//                  Column(
//                   children: question.options
//                       .map(
//                         (option) => ListTile(
//                           title: Text(option),
//                           selected: (selectedOptions[index]) ?? false,
//                           selectedColor: Colors.green,
//                           onTap: () {
//                             setState(() {
//                               selectedOptions[index] = true;
//                             });
//                           },
//                         ),
//                       )
//                       .toList(),
//                 )

//                  Column(
//                   children: question.options
//                       .asMap()
//                       .entries
//                       .map(
//                         (option) => GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedOptions[index] = option.key;
//                               print("$index $selectedOptions[index]");
//                             });
//                           },
//                           child: Container(
//                             color: selectedOptions[index] == option.key
//                                 ? Colors.blueAccent
//                                 : Colors.transparent,
//                             child: ListTile(title: Text(option.value)),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 )
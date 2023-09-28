// import 'package:quiz/services/model/questions_model.dart';
// import 'package:quiz/services/model/quiz_model.dart';

import 'package:quiz/services/cloud/cloud_quiz.dart';

List<CloudQuestions> sampleQuestions1 = [
  // Questions(id: id, question: question, options: options, answerIndex: answerIndex)
  const CloudQuestions(
    question:
        "Flutter is an open-source UI software development kit created by ______",
    options: ['Apple', 'Google', 'Facebook', 'Microsoft'],
    answerIndex: 1,
  ),
  const CloudQuestions(
    question: "When google release Flutter.",
    options: ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    answerIndex: 2,
  ),
  const CloudQuestions(
    question: "A memory location that holds a single letter or number.",
    options: ['Double', 'Int', 'Char', 'Word'],
    answerIndex: 2,
  ),
  const CloudQuestions(
    question: "What command do you use to output data to the screen?",
    options: ['Cin', 'Count>>', 'Cout', 'Output>>'],
    answerIndex: 2,
  )
];

CloudQuiz sampleQuiz1 = CloudQuiz(
  code: 1234,
  name: "sampleQuiz1",
  questions: sampleQuestions1,
  isPublic: true,
);

List<CloudQuestions> sampleQuestions2 = [
  const CloudQuestions(
    question: "Which of the following is NOT a benefit of using Flutter?",
    options: [
      'Cross-platform development',
      'Fast development cycle',
      'Limited widgets',
      'Native performance'
    ],
    answerIndex: 2,
  ),
  const CloudQuestions(
    question: "Which programming language is used to develop Flutter apps?",
    options: ['Dart', 'Java', 'Kotlin', 'Swift'],
    answerIndex: 0,
  ),
  const CloudQuestions(
    question: "What is the name of Flutter's hot reload feature?",
    options: ['State management', 'Hot rebuild', 'Hot reload', 'Live reload'],
    answerIndex: 2,
  ),
  const CloudQuestions(
    question: "What is the name of the Flutter framework's rendering engine?",
    options: ['Skia', 'OpenGL', 'Vulkan', 'Direct3D'],
    answerIndex: 0,
  ),
];

CloudQuiz sampleQuiz2 = CloudQuiz(
  code: 12345,
  name: "sampleQuiz2",
  questions: sampleQuestions2,
  isPublic: true,
);

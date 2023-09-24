import 'package:quiz/services/model/questions_model.dart';
import 'package:quiz/services/model/quiz_model.dart';

List<Questions> sampleQuestions = [
  // Questions(id: id, question: question, options: options, answerIndex: answerIndex)
  Questions(
    id: 1,
    question:
        "Flutter is an open-source UI software development kit created by ______",
    options: ['Apple', 'Google', 'Facebook', 'Microsoft'],
    answerIndex: 1,
  ),
  Questions(
    id: 2,
    question: "When google release Flutter.",
    options: ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    answerIndex: 2,
  ),
  Questions(
    id: 3,
    question: "A memory location that holds a single letter or number.",
    options: ['Double', 'Int', 'Char', 'Word'],
    answerIndex: 2,
  ),
  Questions(
    id: 4,
    question: "What command do you use to output data to the screen?",
    options: ['Cin', 'Count>>', 'Cout', 'Output>>'],
    answerIndex: 2,
  )
];

Quiz sampleQuiz = Quiz(
  code: 1234,
  name: "sampleQuiz",
  questions: sampleQuestions,
);

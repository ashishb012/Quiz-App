import 'package:quiz/services/model/questions_model.dart';

class Quiz {
  final int code;
  final String name;
  final List<Questions> questions;

  Quiz({
    required this.code,
    required this.name,
    required this.questions,
  });
}

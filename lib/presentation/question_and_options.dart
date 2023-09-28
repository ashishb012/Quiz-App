import 'package:flutter/material.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';

// import 'package:quiz/services/model/sample_data.dart';

class QuestionAndOptions extends StatefulWidget {
  final List<CloudQuestions> questions;
  const QuestionAndOptions({super.key, required this.questions});

  @override
  State<QuestionAndOptions> createState() => _QuestionAndOptionsState();
}

class _QuestionAndOptionsState extends State<QuestionAndOptions> {
  late final List<CloudQuestions> questions;
  late Map<int, int?> selectedOptions = {};
  @override
  void initState() {
    questions = widget.questions;
    for (int i = 0; i < questions.length; i++) {
      selectedOptions[i] = -1;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Card(
            margin: const EdgeInsets.all(10.0),
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Q ${index + 1}. ${question.question} ",
                    ),
                  ),
                  // const SizedBox(height: 18.0),
                  Container(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedOptions[index] = -1;
                        });
                      },
                      child: const Text("remove selection"),
                    ),
                  ),
                  // const SizedBox(height: 18.0),
                  Column(
                    children: question.options
                        .asMap()
                        .entries
                        .map(
                          (option) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOptions[index] = option.key;
                                print(selectedOptions);
                              });
                            },
                            child: Container(
                              color: _selectedColor(
                                  selectedOptions[index], option.key),
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
          );
        },
      ),
    );
  }

  Color _selectedColor(int? a, int b) {
    if (a == null) {
      return Colors.transparent;
    }
    if (a == b) {
      return Colors.blueAccent;
    } else {
      return Colors.transparent;
    }
  }
}


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
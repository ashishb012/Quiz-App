import 'package:flutter/material.dart';
import 'package:quiz/presentation/helpers/error_snackbar.dart';
import 'package:quiz/services/cloud/cloud_quiz.dart';
import 'package:quiz/services/cloud/firebase_firestore_storage.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  late final FirebaseCloudStorage _cloudStorage;
  late final TextEditingController _quizNameController;
  late final TextEditingController _questionController;
  late final TextEditingController _option1Controller;
  late final TextEditingController _option2Controller;
  late final TextEditingController _option3Controller;
  late final TextEditingController _option4Controller;
  late int selectedAnswerIndex;
  final List<CloudQuestions> questions = [];

  @override
  void initState() {
    _cloudStorage = FirebaseCloudStorage();

    _quizNameController = TextEditingController();
    _questionController = TextEditingController();
    _option1Controller = TextEditingController();
    _option2Controller = TextEditingController();
    _option3Controller = TextEditingController();
    _option4Controller = TextEditingController();
    selectedAnswerIndex = 1;
    super.initState();
  }

  @override
  void dispose() {
    _quizNameController.dispose();
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    super.dispose();
  }

  void _addQuestion() {
    final questionText = _questionController.text;
    final option1Text = _option1Controller.text;
    final option2Text = _option2Controller.text;
    final option3Text = _option3Controller.text;
    final option4Text = _option4Controller.text;

    if (questionText.isNotEmpty &&
        option1Text.isNotEmpty &&
        option2Text.isNotEmpty &&
        option3Text.isNotEmpty &&
        option4Text.isNotEmpty) {
      setState(() {
        questions.add(CloudQuestions(
          question: questionText,
          options: [option1Text, option2Text, option3Text, option4Text],
          answerIndex: selectedAnswerIndex - 1,
        ));

        _questionController.clear();
        _option1Controller.clear();
        _option2Controller.clear();
        _option3Controller.clear();
        _option4Controller.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Can't add Question with empty fields")),
      );
    }
  }

  void _saveQuiz() async {
    final quizName = _quizNameController.text;
    final code = DateTime.now().microsecondsSinceEpoch;

    if (quizName.isNotEmpty && questions.isNotEmpty) {
      final newQuiz = CloudQuiz(
        code: code,
        name: quizName,
        questions: questions,
        isPublic: true,
      );
      _quizNameController.clear();
      try {
        await _cloudStorage.createNewQuiz(newQuiz);
        // Show a success message or navigate to a different screen
      } catch (e) {
        throw Exception();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Can't save Quiz with empty fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Quiz"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _saveQuiz,
              child: const Text("Save Quiz"),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _quizNameController,
                decoration: const InputDecoration(labelText: 'Quiz Name*'),
                autofocus: true,
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 6.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      title: Text(question.question),
                      subtitle: Text(
                        'Options: ${question.options} \nAnswer ${question.answerIndex}',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _questionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        decoration:
                            const InputDecoration(labelText: 'Question*'),
                      ),
                      TextField(
                        controller: _option1Controller,
                        decoration:
                            const InputDecoration(labelText: 'Option 1*'),
                      ),
                      TextField(
                        controller: _option2Controller,
                        decoration:
                            const InputDecoration(labelText: 'Option 2*'),
                      ),
                      TextField(
                        controller: _option3Controller,
                        decoration:
                            const InputDecoration(labelText: 'Option 3*'),
                      ),
                      TextField(
                        controller: _option4Controller,
                        decoration:
                            const InputDecoration(labelText: 'Option 4*'),
                      ),
                      Row(
                        children: [
                          const Text("Correct answer "),
                          const SizedBox(width: 8.0),
                          DropdownButton<int>(
                            value: selectedAnswerIndex,
                            onChanged: (int? value) {
                              setState(() {
                                selectedAnswerIndex = value ?? -1;
                              });
                            },
                            items: [1, 2, 3, 4]
                                .map((index) => DropdownMenuItem<int>(
                                      value: index,
                                      child: Text('Option $index'),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
              // ElevatedButton(
              //   onPressed: _saveQuiz,
              //   child: const Text('Save Quiz'),
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: _saveQuiz, child: const Icon(Icons.save)),
    );
  }
}


// TODO:   When enter is tapped, the focus should shift to next textfield
//        final FocusNode quizNameFocus = FocusNode();
              //  TextField(
              //   controller: quizNameController,
              //   decoration: InputDecoration(labelText: 'Quiz Name'),
              //   focusNode: quizNameFocus,
              //   onEditingComplete: () {
              //     questionFocus.requestFocus(); // Focus on the next field
              //   },
              // ),
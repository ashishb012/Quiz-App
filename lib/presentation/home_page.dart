import 'package:flutter/material.dart';
import 'package:quiz/l10n/l10n_extensions/loc.dart';
import 'package:quiz/presentation/helpers/error_snackbar.dart';
import 'package:quiz/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DateTime? _lastPressed;

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.loc.hello),
          centerTitle: true,
          elevation: 10.0,
        ),
        drawer: Drawer(
          elevation: 2.0,
          child: ListView(
            padding: const EdgeInsets.only(top: 10, left: 5),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(),
                child: Text(context.loc.app_name,
                    style: const TextStyle(fontSize: 24.0)),
              ),
              ListTile(
                title: const Text("Option 1"),
                onTap: () {
                  //
                  Navigator.of(context).pop();
                },
                onLongPress: () => const Text("Option 1"),
              ),
              ListTile(
                title: const Text("Option 2"),
                onTap: () {
                  //
                  Navigator.of(context).pop();
                },
                onLongPress: () => const Text("Option 2"),
              ),
              ListTile(
                title: const Text("Option 3"),
                onTap: () {
                  //
                  Navigator.of(context).pop();
                },
                onLongPress: () => const Text("Option 3"),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: ListTile(
                  title: Center(
                    child: Text(
                      context.loc.join_quiz,
                    ),
                  ),
                  titleAlignment: ListTileTitleAlignment.bottom,
                  onTap: () => Navigator.of(context).pushNamed(joinQuiz),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 10.0,
                child: ListTile(
                  title: Center(
                    child: Text(
                      context.loc.create_quiz,
                    ),
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  onTap: () => Navigator.of(context).pushNamed(createQuiz),

                  // MaterialPageRoute(
                  //   builder: (context) => const QuizScreen(code: 1234),
                  // ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 10.0,
                child: ListTile(
                    title: Center(
                      child: Text(
                        context.loc.take_quiz,
                      ),
                    ),
                    titleAlignment: ListTileTitleAlignment.bottom,
                    onTap: () => Navigator.of(context).pushNamed(quizList)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

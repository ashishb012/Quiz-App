import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:quiz/presentation/auth/forgot_password_screen.dart';
import 'package:quiz/presentation/auth/login_screen.dart';
import 'package:quiz/presentation/auth/register_screen.dart';
import 'package:quiz/presentation/auth/verify_email_screen.dart';
import 'package:quiz/presentation/create_quiz.dart';
import 'package:quiz/presentation/helpers/loding_screen.dart';
import 'package:quiz/presentation/home_page.dart';
import 'package:quiz/presentation/take_quiz_list.dart';
import 'package:quiz/routes/routes.dart';

import 'package:quiz/services/auth/bloc/auth_bloc.dart';
import 'package:quiz/services/auth/bloc/auth_event.dart';
import 'package:quiz/services/auth/bloc/auth_state.dart';
import 'package:quiz/services/auth/firebase_auth_provider.dart';

import 'package:quiz/theme/dark_theme.dart';
import 'package:quiz/theme/light_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MainPage(),
        // const HomePage(),
      ),
      routes: {
        // quizRoute: (context) => QuizScreen(quiz: null),
        quizList: (context) => const TakeQuiz(),
        createQuiz: (context) => const CreateQuiz(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please wait a moment",
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomePage();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

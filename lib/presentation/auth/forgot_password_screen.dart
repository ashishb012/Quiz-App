import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz/presentation/helpers/error_snackbar.dart';
import 'package:quiz/services/auth/bloc/auth_bloc.dart';
import 'package:quiz/services/auth/bloc/auth_event.dart';
import 'package:quiz/services/auth/bloc/auth_state.dart';
// import 'package:quiz/l10n/l10n_extensions/loc.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            showErrorDailog(
              context,
              "We have sent a password reset. Please check your email for more information.",
            );
          }
          if (state.exception != null) {
            showErrorDailog(
              context,
              '''We could not process your request. 
Make sure your email is registred''',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("If you don't remember your password"),
                const Text(
                    "Enter your email & we'll send a password reset link"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _controller,
                    autocorrect: false,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Your email address",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final email = _controller.text;
                            context
                                .read<AuthBloc>()
                                .add(AuthEventForgotPassword(email: email));
                          },
                          child: const Text("Send link"),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventLogOut());
                          },
                          child: const Text("Back to Login page"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

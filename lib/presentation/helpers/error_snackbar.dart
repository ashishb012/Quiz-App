import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showErrorDailog(BuildContext context, String text) async {
  final snackBar = SnackBar(content: Text(text));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  await HapticFeedback.vibrate();
  await HapticFeedback.vibrate();
}

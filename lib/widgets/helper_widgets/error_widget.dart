import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorWidget({required BuildContext context, required String message, bool isErr=true}) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        backgroundColor: isErr ? (Colors.red) : (Colors.green),
      )
  );
}
import 'package:bookly_app/core/utilities/styles.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        message ?? 'An error occurred',
        style: Styles.textStyle16.copyWith(color: Colors.red),
      ),
    ),
  );
}

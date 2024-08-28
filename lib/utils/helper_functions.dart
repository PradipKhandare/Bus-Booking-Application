import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(date);
}

void showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(date);
}

String getFormattedTime(TimeOfDay tm, {String pattern = 'HH:mm'}) {
  return DateFormat(pattern).format(DateTime(0,0,0,tm.hour,tm.minute));
}

void showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );

int grantTotal(int discount, int totalSeatBooked, int price, int fee) {
  final subTotal = totalSeatBooked * price;
  final priceAfterDiscount = subTotal - ((subTotal * discount) / 100);
  return (priceAfterDiscount + fee).toInt();
}

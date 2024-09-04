import 'package:bus_reservation_udemy/models/reservation_expansion_item.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:flutter/material.dart';

class ReservationItemBodyView extends StatelessWidget {
  final ReservationExpansionBody body;

  const ReservationItemBodyView({Key? key, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Customer Name: ${body.customer.customerName}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
          Text(
            'Customer Mobile: ${body.customer.mobile}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
          Text(
            'Customer Email: ${body.customer.email}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
          Text(
            'Total Seat: ${body.totalSeatedBooked}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
          Text(
            'Seat Numbers: ${body.seatNumbers}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
          Text(
            'Total Price: $currency${body.totalPrice}',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 16,
              color: headingColor,
            ),
          ),
        ],
      ),
    );
  }
}

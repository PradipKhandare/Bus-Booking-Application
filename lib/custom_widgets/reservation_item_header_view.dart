import 'package:bus_reservation_udemy/models/reservation_expansion_item.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class ReservationItemHeaderView extends StatelessWidget {
  final ReservationExpansionHeader header;

  const ReservationItemHeaderView({Key? key, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          '${header.departureDate} ${header.schedule.departureTime}',
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            fontSize: 18,
            color: headingColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${header.schedule.busRoute.routeName}-${header.schedule.bus.busType}',
              style: TextStyle(
                fontFamily: Fonts.fontFamily,
                fontSize: 16,
                color: headingColor,
              ),
            ),
            Text(
              'Booking Time: ${getFormattedDate(DateTime.fromMillisecondsSinceEpoch(header.timestamp), pattern: 'EEE MMM dd yyyy HH:mm')}',
              style: TextStyle(
                fontFamily: Fonts.fontFamily,
                fontSize: 16,
                color: headingColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:bus_reservation_udemy/models/bus_reservation.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/customer.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({Key? key}) : super(key: key);

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late BusSchedule schedule;
  late String departureDate;
  late int totalSeatsBooked;
  late String seatNumbers;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  bool isFirst = true;

  @override
  void initState() {
    nameController.text = 'Mr. ABC';
    mobileController.text = '01711000001';
    emailController.text = 'abc@gmail.com';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isFirst) {
      final argList = ModalRoute.of(context)!.settings.arguments as List;
      departureDate = argList[0];
      schedule = argList[1];
      seatNumbers = argList[2];
      totalSeatsBooked = argList[3];
    }
    isFirst = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Confirm Booking',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: Fonts.fontFamily,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please provide your information',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Fonts.fontFamily,
                  color: headingColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Customer Name',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: mobileController,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: const Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email Address',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Booking Summery',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: Fonts.fontFamily,
                  color: headingColor,
                ),
              ),
            ),
            Card(
              color: blackishColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Name: ${nameController.text}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Mobile Number: ${mobileController.text}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Email Address: ${emailController.text}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Route: ${schedule.busRoute.routeName}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Departure Date: $departureDate',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Departure Time: ${schedule.departureTime}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Ticket Price: $currency${schedule.ticketPrice}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Total Seat(s): $totalSeatsBooked',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Seat Number(s): $seatNumbers',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Discount: ${schedule.discount}%',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Processing Fee: $currency${schedule.processingFee}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                    Text(
                      'Grand Total: $currency${grantTotal(schedule.discount, totalSeatsBooked, schedule.ticketPrice, schedule.processingFee)}',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: Fonts.fontFamily),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12,),
            SizedBox(
              width: 340,
              height: 65,
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: BorderSide(color: Colors.red)
                  )),
                  backgroundColor:
                      WidgetStateProperty.all<Color>(blackishColor),
                ),
                child: const Text(
                  'CONFIRM BOOKING',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: Fonts.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
        customerName: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
      );

      final reservation = BusReservation(
        customer: customer,
        busSchedule: schedule,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        departureDate: departureDate,
        totalSeatBooked: totalSeatsBooked,
        seatNumbers: seatNumbers,
        reservationStatus: reservationActive,
        totalPrice: grantTotal(schedule.discount, totalSeatsBooked,
            schedule.ticketPrice, schedule.processingFee),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addReservation(reservation)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showMessage(context, response.message);
        }
      }).catchError((error) {
        showMessage(context, 'Could not save');
      });
    }
  }
}

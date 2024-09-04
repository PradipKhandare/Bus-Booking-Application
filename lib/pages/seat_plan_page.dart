import 'package:bus_reservation_udemy/custom_widgets/seat_plan_view.dart';
import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  late BusSchedule schedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');

  @override
  void didChangeDependencies() {
    final argsList = ModalRoute.of(context)!.settings.arguments as List;
    schedule = argsList[0];
    departureDate = argsList[1];
    _getData();

    super.didChangeDependencies();
  }

  _getData() async {
    final reservationList =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getReservationsByScheduleAndDepartureDate(
                schedule.scheduleId!, departureDate!);
      setState(() {
        isDataLoading = false;
      });

    List<String> seats = [];

    for (final res in reservationList) {
      totalSeatBooked += res.totalSeatBooked;
      seats.add((res.seatNumbers));
    }
    bookedSeatNumbers = seats.join(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatBookedColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Booked",
                          style: TextStyle(
                              fontSize: 16, fontFamily: Fonts.fontFamily),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatAvailableColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Available",
                          style: TextStyle(
                              fontSize: 16, fontFamily: Fonts.fontFamily),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: selectedSeatStringNotifier,
              builder: (context, value, _) => Text(
                'Selected: $value',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: Fonts.fontFamily,
                ),
              ),
            ),
           if(!isDataLoading) Expanded(
              child: SingleChildScrollView(
                child: SeatPlanView(
                  onSeatSelected: (value, seat) {
                    if (value) {
                      selectedSeats.add(seat);
                    } else {
                      selectedSeats.remove(seat);
                    }

                    selectedSeatStringNotifier.value = selectedSeats.join(',');
                  },
                  totalSeatBooked: totalSeatBooked,
                  bookedSeatNumbers: bookedSeatNumbers,
                  totalSeat: schedule.bus.totalSeat,
                  isBusinessClass: schedule.bus.busType == busTypeACBusiness,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                if (selectedSeats.isEmpty) {
                  showMessage(context, "Please select your seats first.");
                  return;
                }
                Navigator.pushNamed(context, routeNameBookingConfirmationPage,
                    arguments: [
                      departureDate,
                      schedule,
                      selectedSeatStringNotifier.value,
                      selectedSeats.length
                    ]);
              },
              child: const Text(
                "Next",
                style: TextStyle(fontFamily: Fonts.fontFamily),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

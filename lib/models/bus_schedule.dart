
import 'bus_model.dart';
import 'but_route.dart';

class BusSchedule {
  int? scheduleId;
  Bus bus;
  BusRoute busRoute;
  String departureTime;
  int ticketPrice;
  int discount;
  int processingFee;

  BusSchedule(
      {this.scheduleId,
      required this.bus,
        required this.busRoute,
        required this.departureTime,
        required this.ticketPrice,
        this.discount = 0,
        this.processingFee = 50});
}
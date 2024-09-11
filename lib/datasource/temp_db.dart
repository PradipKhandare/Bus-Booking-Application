
import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_schedule.dart';
import '../models/bus_route.dart';
import '../utils/constants.dart';

class TempDB {
  static List<Bus> tableBus = [
    Bus(busId: 1, busName: 'Test Bus', busNumber: 'Test-0001', busType: busTypeACBusiness, totalSeat: 18),
    Bus(busId: 2, busName: 'Test Bus', busNumber: 'Test-0002', busType: busTypeACEconomy, totalSeat: 32),
    Bus(busId: 3, busName: 'Test Bus', busNumber: 'Test-0003', busType: busTypeNonAc, totalSeat: 40),
  ];

  static List<BusRoute> tableRoute = [
    BusRoute(routeId: 1, routeName: 'Pune-Mumbai', cityFrom: 'Pune', cityTo: 'Mumbai', distanceInKm: 250),
    BusRoute(routeId: 2, routeName: 'Mumbai-Pune', cityFrom: 'Mumbai', cityTo: 'Pune', distanceInKm: 250),
  ];
  static List<BusSchedule> tableSchedule = [
    BusSchedule(scheduleId: 1, bus: tableBus[0], busRoute: tableRoute[0], departureTime: '18:00', ticketPrice: 2000,),
    BusSchedule(scheduleId: 2, bus: tableBus[1], busRoute: tableRoute[0], departureTime: '20:00', ticketPrice: 1600,),
    BusSchedule(scheduleId: 3, bus: tableBus[2], busRoute: tableRoute[0], departureTime: '22:00', ticketPrice: 1000,),
    BusSchedule(scheduleId: 4, bus: tableBus[0], busRoute: tableRoute[1], departureTime: '18:00', ticketPrice: 2000,),
  ];
  static List<BusReservation> tableReservation = [];
}
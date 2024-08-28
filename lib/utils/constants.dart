const String currency = '৳';
const String busTypeNonAc = 'NON-AC';
const String busTypeACEconomy = 'AC-ECONOMY';
const String busTypeACBusiness = 'AC-BUSINESS';
const String reservationConfirmed = 'Confirmed';
const String reservationCancelled = 'Cancelled';
const String reservationActive = 'Active';
const String reservationExpired = 'Expired';
const String emptyFieldErrMessage = 'This field must not be empty';
const String accessToken = 'accessToken';
const String loginTime = 'loginTime';
const String expirationDuration = 'expirationDuration';
const String routeNameHome = 'search';
const String routeNameSearchResultPage = 'search_result';
const String routeNameLoginPage = 'login';
const String routeNameSeatPlanPage = 'seat_plan';
const String routeNameBookingConfirmationPage = 'booking_confirmation';
const String routeNameAddBusPage = 'add_bus';
const String routeNameAddRoutePage = 'add_route';
const String routeNameAddSchedulePage = 'add_schedule';
const String routeNameScheduleListPage = 'schedule_list';
const String routeNameReservationPage = 'reservation';
const String emptyDateErrorMessage = 'Please select a departure date';

const cities = [
  'Pune',
  'Mumbai',
  'Amrawati',
  'Nagpur',
  'Beed',
  'Sambhaji Nagar',
  'Chopda',
  'Mehkar',
  'Kolhapur',
  'Sangli',
  'Satara'
];

enum ResponseStatus {
  SAVED, FAILED, UNAUTHORIZED, AUTHORIZED, EXPIRED, NONE,
}

const busTypes = [busTypeACBusiness, busTypeACEconomy, busTypeNonAc];

const seatLabelList = ['A','B','C','D','E','F','G','H','I','J','K','L'];


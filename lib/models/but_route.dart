class BusRoute {
  int? routeId;
  String routeName;
  String cityFrom;
  String cityTo;
  double distanceInKm;

  BusRoute(
      {this.routeId,
      required this.routeName,
      required this.cityFrom,
      required this.cityTo,
      required this.distanceInKm});
}
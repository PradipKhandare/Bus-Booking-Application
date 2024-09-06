package com.busBooking.ReservationBus.service;

import com.busBooking.ReservationBus.entity.Bus;
import com.busBooking.ReservationBus.entity.BusRoute;

import java.util.List;

public interface BusRouteService {

    BusRoute addRoute(BusRoute busRoute);

    List<BusRoute> getAllRoutes();

    BusRoute getRouteByRouteName(String routeName);

    BusRoute getRouteByCityFromAndCityTo(String cityFrom, String cityTo);

}

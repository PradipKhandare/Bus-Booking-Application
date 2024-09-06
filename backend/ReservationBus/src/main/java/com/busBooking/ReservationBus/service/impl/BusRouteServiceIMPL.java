package com.busBooking.ReservationBus.service.impl;


import com.busBooking.ReservationBus.entity.BusRoute;
import com.busBooking.ReservationBus.models.ReservationAPIException;
import com.busBooking.ReservationBus.repos.BusRouteRepository;
import com.busBooking.ReservationBus.service.BusRouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusRouteServiceIMPL implements BusRouteService {

    @Autowired
    private BusRouteRepository busRouteRepository;

    @Override
    public BusRoute addRoute(BusRoute busRoute) {
        return busRouteRepository.save(busRoute);
    }

    @Override
    public List<BusRoute> getAllRoutes() {
        return busRouteRepository.findAll();
    }

    @Override
    public BusRoute getRouteByRouteName(String routeName) {
        return busRouteRepository.findByRouteName(routeName).orElseThrow(() -> new ReservationAPIException(HttpStatus.BAD_REQUEST,"Route not found"));
    }

    @Override
    public BusRoute getRouteByCityFromAndCityTo(String cityFrom, String cityTo) {
        return busRouteRepository.findByCityFromAndCityTo(cityFrom, cityTo).orElseThrow(() -> new ReservationAPIException(HttpStatus.BAD_REQUEST,"Route not found"));
    }
}

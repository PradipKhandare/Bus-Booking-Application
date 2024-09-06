package com.busBooking.ReservationBus.service.impl;


import com.busBooking.ReservationBus.entity.BusRoute;
import com.busBooking.ReservationBus.entity.BusSchedule;
import com.busBooking.ReservationBus.models.ReservationAPIException;
import com.busBooking.ReservationBus.repos.BusRouteRepository;
import com.busBooking.ReservationBus.repos.BusScheduleRepository;
import com.busBooking.ReservationBus.service.BusScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.management.relation.RelationServiceNotRegisteredException;
import java.util.List;

@Service
public class BusScheduleServiceIMPL implements BusScheduleService {

    @Autowired
    private BusScheduleRepository busScheduleRepository;

    @Autowired
    private BusRouteRepository busRouteRepository;

    @Override
    public BusSchedule addBusSchedule(BusSchedule busSchedule) throws ReservationAPIException{
        final boolean exists = busScheduleRepository.existsByBusAndBusRouteAndDepartureTime(busSchedule.getBus(), busSchedule.getBusRoute(), busSchedule.getDepartureTime());
       if(exists){
           throw new ReservationAPIException(HttpStatus.CONFLICT, "Duplicate Schedule");
       }
       return busScheduleRepository.save(busSchedule);
    }

    @Override
    public List<BusSchedule> getAllBusSchedule() {
        return busScheduleRepository.findAll();
    }

    @Override
    public List<BusSchedule> getSchedulesByRoute(String routeName) {
       final BusRoute busRoute = busRouteRepository.findByRouteName(routeName).orElseThrow(() -> new ReservationAPIException(HttpStatus.NOT_FOUND,"route not found"));
       return busScheduleRepository.findByBusRoute(busRoute).orElseThrow(() -> new ReservationAPIException(HttpStatus.NOT_FOUND,"route not found"));
    }
}

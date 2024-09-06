package com.busBooking.ReservationBus.service;

import com.busBooking.ReservationBus.entity.BusSchedule;

import java.util.List;

public interface BusScheduleService {

    BusSchedule addBusSchedule(BusSchedule busSchedule);

    List<BusSchedule> getAllBusSchedule();

    List<BusSchedule> getSchedulesByRoute(String routeName);

}

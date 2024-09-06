package com.busBooking.ReservationBus.service;

import com.busBooking.ReservationBus.entity.Bus;

import java.util.List;

public interface BusService {

    Bus addBus(Bus bus);

    List<Bus> getAllBuses();

}

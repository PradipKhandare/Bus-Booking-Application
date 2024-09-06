package com.busBooking.ReservationBus.service.impl;

import com.busBooking.ReservationBus.entity.Bus;
import com.busBooking.ReservationBus.repos.BusRepository;
import com.busBooking.ReservationBus.service.BusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusServiceIMPL implements BusService {

    @Autowired
    private BusRepository busRepository;

    @Override
    public Bus addBus(Bus bus) {

        return busRepository.save(bus);
    }

    @Override
    public List<Bus> getAllBuses() {
        return busRepository.findAll();
    }
}

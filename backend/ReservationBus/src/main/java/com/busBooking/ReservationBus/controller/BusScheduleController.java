package com.busBooking.ReservationBus.controller;


import com.busBooking.ReservationBus.entity.BusSchedule;
import com.busBooking.ReservationBus.models.ResponseModel;
import com.busBooking.ReservationBus.service.BusScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/schedule")
public class BusScheduleController {


    @Autowired
    private BusScheduleService busScheduleService;


    @PostMapping("/add")
    public ResponseModel<BusSchedule> addBusSchedule(@RequestBody BusSchedule busSchedule) {
       final BusSchedule busSchedule1 = busScheduleService.addBusSchedule(busSchedule);
       return new ResponseModel<>(HttpStatus.OK.value(), "Schedule saved", busSchedule1);
    }

    @GetMapping("/all")
    public ResponseEntity<List<BusSchedule>> getAllBusSchedule() {
        final List<BusSchedule> busSchedules = busScheduleService.getAllBusSchedule();
        return new ResponseEntity<>(busSchedules, HttpStatus.OK);
    }

    @GetMapping("/{routeName}")
    public ResponseEntity<List<BusSchedule>> getBusSchedule(@PathVariable(name = "routeName") String routeName) {
        return ResponseEntity.ok(busScheduleService.getSchedulesByRoute(routeName));
    }
}

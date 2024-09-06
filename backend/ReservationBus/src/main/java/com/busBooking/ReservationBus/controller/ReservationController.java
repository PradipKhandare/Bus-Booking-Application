package com.busBooking.ReservationBus.controller;


import com.busBooking.ReservationBus.entity.Reservation;
import com.busBooking.ReservationBus.models.ResponseModel;
import com.busBooking.ReservationBus.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @PostMapping("/add")
    public ResponseModel<Reservation> addReservation(@RequestBody Reservation reservation) {
        final Reservation result = reservationService.addReservation(reservation);
        return new ResponseModel<>(HttpStatus.OK.value(), "Reservation added successfully", result);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Reservation>> getAllReservations() {
        return new ResponseEntity<>(reservationService.getAllReservations(), HttpStatus.OK);
    }

    @GetMapping("/query")
    public ResponseEntity<List<Reservation>> getAllReservationByScheduleAndDepartureDate(
            @RequestParam Long scheduleId,
            @RequestParam String departureDate) {
        return ResponseEntity.ok(reservationService.getReservationsByScheduleAndDepartureDate(scheduleId, departureDate));
    }


    @GetMapping("/all/{mobile}")
    public ResponseEntity<List<Reservation>> getAllReservationsByMobile(@PathVariable(name = "mobile") String mobile) {
        return ResponseEntity.ok(reservationService.getReservationsByMobile(mobile));
    }
}

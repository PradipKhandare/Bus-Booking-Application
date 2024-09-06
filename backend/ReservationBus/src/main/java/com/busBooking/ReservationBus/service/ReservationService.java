package com.busBooking.ReservationBus.service;

import com.busBooking.ReservationBus.entity.Reservation;

import java.util.List;

public interface ReservationService {

    Reservation addReservation(Reservation reservation);

    List<Reservation> getAllReservations();

    List<Reservation> getReservationsByScheduleAndDepartureDate(Long scheduleId, String departureDate);

    List<Reservation> getReservationsByMobile(String mobile);
}

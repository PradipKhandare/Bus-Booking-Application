package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.BusSchedule;
import com.busBooking.ReservationBus.entity.Customer;
import com.busBooking.ReservationBus.entity.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {

    Optional<List<Reservation>> findByCustomer(Customer customer);

    Optional<List<Reservation>> findByBusScheduleAndDepartureDate(BusSchedule busSchedule, String departureDate);

}

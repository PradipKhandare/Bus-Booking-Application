package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.Bus;
import com.busBooking.ReservationBus.entity.BusRoute;
import com.busBooking.ReservationBus.entity.BusSchedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BusScheduleRepository extends JpaRepository<BusSchedule, Long> {

    Optional<List<BusSchedule>> findByBusRoute(BusRoute busRoute);

    Boolean existsByBusAndBusRouteAndDepartureTime(Bus bus, BusRoute busRoute, String date);
}

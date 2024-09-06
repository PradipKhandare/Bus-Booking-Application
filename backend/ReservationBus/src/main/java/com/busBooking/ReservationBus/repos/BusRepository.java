package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.Bus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusRepository extends JpaRepository<Bus, Long> {
}

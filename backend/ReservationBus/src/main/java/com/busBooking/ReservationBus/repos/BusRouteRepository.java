package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.BusRoute;
import org.springframework.data.jpa.repository.JpaRepository;

import java.awt.*;
import java.util.Optional;

public interface BusRouteRepository extends JpaRepository<BusRoute, Long> {

   Optional<BusRoute> findByRouteName(String routeName);
   Optional<BusRoute> findByCityFromAndCityTo(String cityFrom, String cityTo);

}

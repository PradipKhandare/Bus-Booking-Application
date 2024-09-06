package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.AppUsers;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AppUserRepository extends JpaRepository<AppUsers, Long> {

    Optional<AppUsers> findByUserName(String userName);
}

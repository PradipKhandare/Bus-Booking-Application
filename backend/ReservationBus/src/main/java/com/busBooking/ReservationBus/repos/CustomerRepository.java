package com.busBooking.ReservationBus.repos;

import com.busBooking.ReservationBus.entity.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Long> {

    Optional<Customer> findByMobileOrEmail(String mobile, String email);

    Optional<Customer> findByEmail(String email);

    Optional<Customer> findByMobile(String mobile);

    Boolean existsByMobile(String mobile);

    Boolean existsByEmail(String email);

    Boolean existsByMobileOrEmail(String mobile, String email);

}

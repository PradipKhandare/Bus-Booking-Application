package com.busBooking.ReservationBus.service.impl;

import com.busBooking.ReservationBus.entity.BusSchedule;
import com.busBooking.ReservationBus.entity.Customer;
import com.busBooking.ReservationBus.entity.Reservation;
import com.busBooking.ReservationBus.models.ReservationAPIException;
import com.busBooking.ReservationBus.repos.BusScheduleRepository;
import com.busBooking.ReservationBus.repos.CustomerRepository;
import com.busBooking.ReservationBus.repos.ReservationRepository;
import com.busBooking.ReservationBus.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationServiceIMPL implements ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private BusScheduleRepository busScheduleRepository;

    @Override
    public Reservation addReservation(Reservation reservation) {
        final Customer customer;
        final boolean doesCustomerExist = customerRepository.existsByMobileOrEmail(reservation.getCustomer().getMobile(), reservation.getCustomer().getEmail());
        if (doesCustomerExist) {
            customer = customerRepository.findByMobileOrEmail(reservation.getCustomer().getMobile(), reservation.getCustomer().getEmail()).orElseThrow(() ->new ReservationAPIException(HttpStatus.NOT_FOUND,"route not found"));
        }else {
            customer= customerRepository.save(reservation.getCustomer());
        }
        reservation.setCustomer(customer);
        return reservationRepository.save(reservation);
    }

    @Override
    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    @Override
    public List<Reservation> getReservationsByScheduleAndDepartureDate(Long scheduleId, String departureDate) {
        final BusSchedule schedule = busScheduleRepository
                                .findById(scheduleId)
                                .orElseThrow(() -> new ReservationAPIException(HttpStatus.BAD_REQUEST,"schedule not found"));
        return reservationRepository
                .findByBusScheduleAndDepartureDate(schedule, departureDate)
                .orElseThrow(() -> new ReservationAPIException(HttpStatus.BAD_REQUEST,"reservation not found"));
    }

    @Override
    public List<Reservation> getReservationsByMobile(String mobile) {
        final Customer customer = customerRepository
                .findByMobile(mobile)
                .orElseThrow(() -> new ReservationAPIException(HttpStatus.BAD_REQUEST,"no record found"));
        return reservationRepository.findByCustomer(customer).orElseThrow(() -> new ReservationAPIException(HttpStatus.NOT_FOUND,"customer not found"));
    }
}

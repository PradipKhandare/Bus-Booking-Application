package com.busBooking.ReservationBus.entity;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "bus_schedule")
public class BusSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long scheduleId;
    
    @OneToOne
    @JoinColumn(name = "bus_id")
    private Bus bus;

    @OneToOne
    @JoinColumn(name = "bus_route_id")
    private BusRoute busRoute;

    private String departureTime;
    private Integer ticketPrice;
    private Integer discount;
    private Integer processingFee;
}

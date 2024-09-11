package com.busBooking.ReservationBus.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "bus_route")
public class BusRoute {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long routeId;
    private String routeName;
    private String cityFrom;
    private String cityTo;
    private Double distanceInKm;
}

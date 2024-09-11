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
@Entity(name = "bus")
public class Bus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long busId;
    private String busName;
    @Column(unique = true)
    private String busNumber;
    private String busType;
    private Integer totalSeat;
}

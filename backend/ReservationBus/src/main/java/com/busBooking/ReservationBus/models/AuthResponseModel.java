package com.busBooking.ReservationBus.models;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponseModel {

    private int statusCode;
    private String message;
    private String accessToken;
    private Long loginTime;
    private Long expirationTeime;



}

package com.busBooking.ReservationBus.controller;


import com.busBooking.ReservationBus.entity.AppUsers;
import com.busBooking.ReservationBus.models.AuthResponseModel;
import com.busBooking.ReservationBus.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AuthController {


    @Value("${app.jwt-expiration-milliseconds}")
    private Long expiration;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @PostMapping("/login")
    public ResponseEntity<AuthResponseModel> login(@RequestBody AppUsers user) {
        final AuthResponseModel authResponseModel;
        final Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        user.getUserName(), user.getPassword()
                ));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtTokenProvider.generateToken(authentication);
        authResponseModel = new AuthResponseModel(
                HttpStatus.OK.value(), "Successfully login",token,System.currentTimeMillis(),
                expiration
        );
        return ResponseEntity.ok(authResponseModel);
    }
}
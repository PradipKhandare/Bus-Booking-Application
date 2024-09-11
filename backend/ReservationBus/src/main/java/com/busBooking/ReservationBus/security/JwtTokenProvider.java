package com.busBooking.ReservationBus.security;


import com.busBooking.ReservationBus.models.ReservationAPIException;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Base64;
import java.util.Date;

@Component
public class JwtTokenProvider {

    @Value("${app.jwt-secret}")
    private String jwtSecretKey;

    @Value("${app.jwt-expiration-milliseconds}")
    private Long expirationTime;


    public String generateToken(Authentication authentication){
        String userName = authentication.getName();
        //String userName = authentication.();
        Date expireDate = new Date(new Date().getTime() + expirationTime);

        return Jwts.builder()
                .setSubject(userName)
                .setIssuedAt(new Date())
                .setExpiration(expireDate)
                .signWith(key())
                .compact();
    }

    public String getUserName(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(key())
                .build()
                .parseClaimsJws(token)
                .getBody();
        return claims.getSubject();
    }

    public boolean validateToken(String token){
        try{
            Jwts.parser().setSigningKey(key()).build().parse(token);
            return true;
        }catch(MalformedJwtException e){
            throw new ReservationAPIException(HttpStatus.BAD_REQUEST,"Invalid token");
        }catch(ExpiredJwtException e){
            throw new ReservationAPIException(HttpStatus.BAD_REQUEST,"token exception");
        }catch(UnsupportedJwtException e){
            throw new ReservationAPIException(HttpStatus.BAD_REQUEST,"token unsupported");
        }catch(IllegalArgumentException e){
            throw new ReservationAPIException(HttpStatus.BAD_REQUEST,"Invalid argument");
        }
    }

    private Key key(){
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecretKey));
    }
}
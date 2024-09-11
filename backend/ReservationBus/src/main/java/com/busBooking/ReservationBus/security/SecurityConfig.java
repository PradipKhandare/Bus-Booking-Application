package com.busBooking.ReservationBus.security;


import com.busBooking.ReservationBus.service.CustomUserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
public class SecurityConfig {

    @Autowired
    private JwtEntryPoint jwtEntryPoint;

    @Autowired
    private CustomUserDetailService customUserDetailService;

    @Autowired
    private JwtAuthFilter jwtAuthFilter;

    @Bean
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity httpSecurity) throws Exception{
        httpSecurity.csrf().disable()
                .authorizeHttpRequests()
                .requestMatchers(HttpMethod.GET)
                .permitAll()
                .requestMatchers("/api/auth/**")
                .permitAll()
                .requestMatchers(HttpMethod.POST,"/api/bus/add", "/api/schedule/add", "/api/route/addd")
                .authenticated()
                .requestMatchers(HttpMethod.POST, "api/reservation/add")
                .permitAll()
                .and()
                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtEntryPoint))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        httpSecurity.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class);
        return httpSecurity.build();
    }


    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception{
        return authenticationConfiguration.getAuthenticationManager();
    }


}
package com.busBooking.ReservationBus.models;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.nio.file.AccessDeniedException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ReservationAPIException.class)
    public ResponseEntity<ErrorDetails> handleReservationApiException(ReservationAPIException reservationAPIException, WebRequest webRequest) {
        ErrorDetails errorDetails = new ErrorDetails();
        errorDetails.setErrorCode(reservationAPIException.getStatus().value());
        errorDetails.setErrorMessage(reservationAPIException.getMessage());
        errorDetails.setDeveloperMessage(webRequest.getDescription(false));
        errorDetails.setTimestamp(System.currentTimeMillis());

        return new ResponseEntity<>(errorDetails, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorDetails> handleAccessDeniedException(AccessDeniedException accessDeniedException, WebRequest webRequest) {
        ErrorDetails errorDetails = new ErrorDetails();
        errorDetails.setErrorMessage(accessDeniedException.getMessage());
        errorDetails.setDeveloperMessage(webRequest.getDescription(false));
        errorDetails.setTimestamp(System.currentTimeMillis());

        return new ResponseEntity<>(errorDetails, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorDetails> handleGlobalException(Exception exception, WebRequest webRequest) {
        ErrorDetails errorDetails = new ErrorDetails();
        errorDetails.setErrorMessage(exception.getMessage());
        errorDetails.setDeveloperMessage(webRequest.getDescription(false));
        errorDetails.setTimestamp(System.currentTimeMillis());

        return new ResponseEntity<>(errorDetails, HttpStatus.BAD_REQUEST);
    }
}

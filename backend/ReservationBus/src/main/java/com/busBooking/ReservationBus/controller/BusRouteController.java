package com.busBooking.ReservationBus.controller;

import com.busBooking.ReservationBus.entity.BusRoute;
import com.busBooking.ReservationBus.models.ResponseModel;
import com.busBooking.ReservationBus.service.BusRouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/route")
public class BusRouteController {

    @Autowired
    private BusRouteService busRouteService;

    @PostMapping("/add")
    public ResponseModel<BusRoute> addRoute(@RequestBody BusRoute busRoute) {
        final BusRoute busRoute1 = busRouteService.addRoute(busRoute);
        return new ResponseModel<>(HttpStatus.OK.value(), "Route Saved", busRoute1);
    }

    @GetMapping("/all")
    public ResponseEntity<List<BusRoute>> getAllRoutes() {
        return new ResponseEntity<>(busRouteService.getAllRoutes(), HttpStatus.OK);
    }

    @GetMapping("/{routeName}")
    public ResponseEntity<BusRoute> getRouteByRouteName(@PathVariable(name = "routeName") String routeName) {
        return new ResponseEntity<>(busRouteService.getRouteByRouteName(routeName), HttpStatus.OK);
    }

    @GetMapping("/query")
    public ResponseEntity<BusRoute> getRoutesByCityFromAndCityTo(@RequestParam String cityFrom, @RequestParam String cityTo) {
            return ResponseEntity.ok(busRouteService.getRouteByCityFromAndCityTo(cityFrom, cityTo));
    }
}

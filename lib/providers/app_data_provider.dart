



import 'package:bus_reservation_udemy/datasource/data_source.dart';
import 'package:bus_reservation_udemy/datasource/dummy_data_source.dart';
import 'package:bus_reservation_udemy/models/but_route.dart';
import 'package:flutter/material.dart';

class AppDataProvider extends ChangeNotifier
{
  final DataSource dataSource = DummyDataSource();
    Future<BusRoute?> getRouteByCityFromAndCityTo(String cityFrom, String cityTo){
            return dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
    }
}

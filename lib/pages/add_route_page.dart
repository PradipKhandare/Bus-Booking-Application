import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/but_route.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddRoutePage extends StatefulWidget {
  const AddRoutePage({Key? key}) : super(key: key);

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {
  final _formKey = GlobalKey<FormState>();
  String? from, to;
  final distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Add Route',
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            shrinkWrap: true,
            children: [
              DropdownButtonFormField<String>(
                onChanged: (value) {
                  setState(() {
                    from = value;
                  });
                },
                isExpanded: true,
                value: from,
                hint: const Text(
                  'From',
                  style: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                    fontSize: 19,
                  ),
                ),
                items: cities
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 5,
              ),
              DropdownButtonFormField<String>(
                onChanged: (value) {
                  setState(() {
                    to = value;
                  });
                },
                isExpanded: true,
                value: to,
                hint: const Text(
                  'To',
                  style: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                    fontSize: 19,
                  ),
                ),
                items: cities
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: distanceController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Distance in Kilometer',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.social_distance_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      )),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(blackishColor),
                    ),
                    onPressed: addRoute,
                    child: const Text(
                      'ADD ROUTE',
                      style: TextStyle(
                          fontFamily: Fonts.fontFamily,
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addRoute() {
    if (_formKey.currentState!.validate()) {
      final route = BusRoute(
        routeId: TempDB.tableRoute.length + 1,
        routeName: '$from-$to',
        cityFrom: from!,
        cityTo: to!,
        distanceInKm: double.parse(distanceController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addRoute(route)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetFields();
        }
      });
    }
  }

  @override
  void dispose() {
    distanceController.dispose();
    super.dispose();
  }

  void resetFields() {
    distanceController.clear();
  }
}

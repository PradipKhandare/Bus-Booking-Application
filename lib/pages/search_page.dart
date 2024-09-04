import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/drawer/main_drawer.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text(
          "Search Buses",
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: [
              Image.asset(
                "assets/img/pngegg.png",
                height: 100,
                width: 150,
              ),
              DropdownButtonFormField<String>(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                hint: const Text(
                  "From",
                  style: TextStyle(fontFamily: Fonts.fontFamily),
                ),
                isExpanded: true,
                items: cities
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(fontFamily: Fonts.fontFamily),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  fromCity = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                hint: const Text(
                  "To",
                  style: TextStyle(fontFamily: Fonts.fontFamily),
                ),
                isExpanded: true,
                items: cities
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(fontFamily: Fonts.fontFamily),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  toCity = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _selectDate,
                      child: const Text(
                        "Date of Journey",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: Fonts.fontFamily,
                        ),
                      ),
                    ),
                    Text(
                      departureDate == null
                          ? 'No Date Chosen'
                          : getFormattedDate(departureDate!,
                              pattern: 'EEE MMM dd, yyyy'),
                      style: TextStyle(fontFamily: Fonts.fontFamily),
                    )
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 65,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(seatSelectedColor),
                    ),
                    onPressed: _search,
                    child: const Text(
                      'Search',
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

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 7),
      ),
    );
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMessage(context, emptyDateErrorMessage);
      return;
    }

    if (_formKey.currentState!.validate()) {
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((route) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [route, getFormattedDate(departureDate!)]);
      });
    }
  }
}

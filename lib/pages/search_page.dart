import 'dart:ui';

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
      backgroundColor: buttonColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Find Your Bus",
          style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/img/bus.png",
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    children: [
                      // Image.asset(
                      //   "assets/img/pngegg.png",
                      //   height: 100,
                      //   width: 150,
                      //   color: thingsColor,
                      // ),
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
                          style: TextStyle(
                            fontFamily: Fonts.fontFamily,
                            color: headingColor,
                            fontSize: 20,
                          ),
                        ),
                        isExpanded: true,
                        items: cities
                            .map((city) => DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style:
                                        TextStyle(fontFamily: Fonts.fontFamily),
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
                          style: TextStyle(
                              fontFamily: Fonts.fontFamily,
                              color: headingColor,
                              fontSize: 20),
                        ),
                        isExpanded: true,
                        items: cities
                            .map((city) => DropdownMenuItem<String>(
                                  value: city,
                                  child: Text(
                                    city,
                                    style:
                                        TextStyle(fontFamily: Fonts.fontFamily),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          toCity = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                                color: containerBackgroundColor,
                              ),
                              width: 168,
                              child: TextButton(
                                onPressed: _selectDate,
                                child: const Text(
                                  "Date of Journey",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Fonts.fontFamily,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              departureDate == null
                                  ? 'No Date Chosen'
                                  : getFormattedDate(departureDate!,
                                      pattern: 'EEE MMM dd, yyyy'),
                              style: const TextStyle(
                                fontFamily: Fonts.fontFamily,
                                color: headingColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: SizedBox(
                          width: 350,
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                // side: BorderSide(color: Colors.red)
                              )),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(blackishColor),
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
            ),
          ],
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

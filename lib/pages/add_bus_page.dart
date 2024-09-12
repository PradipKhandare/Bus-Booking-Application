import 'package:bus_reservation_udemy/custom_widgets/login_alert_dialog.dart';
import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bus_model.dart';
import '../utils/constants.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({Key? key}) : super(key: key);

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final _formKey = GlobalKey<FormState>();
  String? busType;
  final seatController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Add Bus',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                shrinkWrap: true,
                children: [
                  DropdownButtonFormField<String>(
                    onChanged: (value) {
                      setState(() {
                        busType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a Bus Type';
                      }
                    },
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    isExpanded: true,
                    value: busType,
                    hint: const Text(
                      'Select Bus Type',
                      style: TextStyle(
                        fontFamily: Fonts.fontFamily,
                        color: headingColor,
                        fontSize: 19,
                      ),
                    ),
                    items: busTypes
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Bus Name',
                      hintStyle: TextStyle(
                        fontFamily: Fonts.fontFamily,
                        color: headingColor,
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.bus_alert),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    controller: numberController,
                    decoration: const InputDecoration(
                      hintText: 'Bus Number',
                      hintStyle: TextStyle(
                        fontFamily: Fonts.fontFamily,
                        color: headingColor,
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.bus_alert),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: seatController,
                    decoration: const InputDecoration(
                      hintText: 'Total Seats',
                      hintStyle: TextStyle(
                        fontFamily: Fonts.fontFamily,
                        color: headingColor,
                      ),
                      filled: true,
                      prefixIcon: Icon(Icons.event_seat),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                        onPressed: addBus,
                        child: const Text(
                          'ADD BUS',
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
      ),
    );
  }

  void addBus() {
    if (_formKey.currentState!.validate()) {
      final bus = Bus(
        //busId: TempDB.tableBus.length + 1,
        // remove this line if you save into MySql DB
        busName: nameController.text,
        busNumber: numberController.text,
        busType: busType!,
        totalSeat: int.parse(seatController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addBus(bus)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetFields();
        } else if (response.responseStatus == ResponseStatus.EXPIRED ||
            response.responseStatus == ResponseStatus.UNAUTHORIZED) {
          showLoginAlertDialog(
              context: context,
              message: response.message,
              callback: () {
                Navigator.pushNamed(context, routeNameLoginPage);
              });
        }
      });
    }
  }

  void resetFields() {
    numberController.clear();
    seatController.clear();
    nameController.clear();
  }

  @override
  void dispose() {
    seatController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }
}

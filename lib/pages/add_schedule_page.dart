import 'package:bus_reservation_udemy/utils/colors.dart';
import 'package:bus_reservation_udemy/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datasource/temp_db.dart';
import '../models/bus_model.dart';
import '../models/bus_schedule.dart';
import '../models/but_route.dart';
import '../providers/app_data_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({Key? key}) : super(key: key);

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final _formKey = GlobalKey<FormState>();

  String? busType;
  BusRoute? busRoute;
  Bus? bus;
  TimeOfDay? timeOfDay;

  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final feeController = TextEditingController();

  @override
  void didChangeDependencies() {
    _getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Add Schedule',
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
              const SizedBox(height: 10,),
              Consumer<AppDataProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<Bus>(
                  onChanged: (value) {
                    setState(() {
                      bus = value;
                    });
                  },
                  isExpanded: true,
                  value: bus,
                  hint: const Text(
                    'Select Bus',
                    style: TextStyle(
                      fontFamily: Fonts.fontFamily,
                      color: headingColor,
                      fontSize: 19,
                    ),
                  ),
                  items: provider.busList
                      .map((e) => DropdownMenuItem<Bus>(
                            value: e,
                            child: Text('${e.busName}-${e.busType}'),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 15,),
              Consumer<AppDataProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<BusRoute>(
                  onChanged: (value) {
                    setState(() {
                      busRoute = value;
                    });
                  },
                  isExpanded: true,
                  value: busRoute,
                  hint: const Text(
                    'Select Route',
                    style: TextStyle(
                      fontFamily: Fonts.fontFamily,
                      color: headingColor,
                      fontSize: 19,
                    ),
                  ),
                  items: provider.routeList
                      .map((e) => DropdownMenuItem<BusRoute>(
                            value: e,
                            child: Text(e.routeName),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Ticket Price',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.price_change),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: discountController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Discount(%)',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.discount),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: feeController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Processing Fee',
                  hintStyle: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      color: containerBackgroundColor,
                    ),
                    child: TextButton(
                      onPressed: _selectTime,
                      child: const Text(
                        'Select Departure Time',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.fontFamily,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(timeOfDay == null
                      ? 'No time chosen'
                      : getFormattedTime(timeOfDay!),style: const TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: headingColor,
                  ),),
                ],
              ),
              const SizedBox(height: 20,),
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
                    onPressed: addSchedule,
                    child: const Text('ADD SCHEDULE',style: TextStyle(
                        fontFamily: Fonts.fontFamily,
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addSchedule() {
    if (timeOfDay == null) {
      showMessage(context, 'Please select a departure time');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final schedule = BusSchedule(
        scheduleId: TempDB.tableSchedule.length + 1,
        bus: bus!,
        busRoute: busRoute!,
        departureTime: getFormattedTime(timeOfDay!),
        ticketPrice: int.parse(priceController.text),
        discount: int.parse(discountController.text),
        processingFee: int.parse(feeController.text),
      );
      Provider.of<AppDataProvider>(context, listen: false)
          .addSchedule(schedule)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMessage(context, response.message);
          resetFields();
        }
      });
    }
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (time != null) {
      setState(() {
        timeOfDay = time;
      });
    }
  }

  void resetFields() {
    priceController.clear();
    discountController.clear();
    feeController.clear();
  }

  void _getData() {
    Provider.of<AppDataProvider>(context, listen: false).getAllBus();
    Provider.of<AppDataProvider>(context, listen: false).getAllBusRoutes();
  }
}

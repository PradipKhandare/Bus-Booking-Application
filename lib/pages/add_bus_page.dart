import 'package:bus_reservation_udemy/datasource/temp_db.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
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
      appBar: AppBar(
        title: const Text('Add Bus'),
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
                    busType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Bus Type';
                  }
                },
                decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.white70)),
                isExpanded: true,
                value: busType,
                hint: const Text('Select Bus Type'),
                items: busTypes
                    .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Bus Name',
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
                height: 5,
              ),
              TextFormField(
                controller: numberController,
                decoration: const InputDecoration(
                  hintText: 'Bus Number',
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
                height: 5,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: seatController,
                decoration: const InputDecoration(
                  hintText: 'Total Seats',
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
                height: 5,
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: addBus,
                    child: const Text('ADD BUS'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addBus() {
    if (_formKey.currentState!.validate()) {
      final bus = Bus(
        busId: TempDB.tableBus.length +
            1, // remove this line if you save into MySql DB
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

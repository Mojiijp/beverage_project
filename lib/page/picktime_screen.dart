// ignore: file_names
// ignore_for_file: unused_import

import 'package:beverage_project/page/pay_screen.dart';
import 'package:flutter/material.dart';

class PickTimeScreen extends StatefulWidget {
  const PickTimeScreen({Key? key}) : super(key: key);

  @override
  State<PickTimeScreen> createState() => _PickTimeScreenState();
}

class _PickTimeScreenState extends State<PickTimeScreen> {

  //create datetime variable
  DateTime _date = DateTime.now();
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  //show date picker method

  // ignore: non_constant_identifier_names
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  // ignore: unused_element
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //display choose date
            // Text(
            //   _date.toString(),
            //   style: const TextStyle(
            //     fontSize: 20,
            //   ),
            // ),
            //
            // //button
            // MaterialButton(
            //     onPressed: _showDatePicker,
            //     color: Colors.blue,
            //     child: const Padding(
            //       padding: EdgeInsets.all(20.0),
            //       child: Text(
            //         "Choose Date",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20,
            //         ),
            //       ),
            //     )
            // ),

            Text(
              _timeOfDay.format(context).toString(),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            MaterialButton(
                onPressed: _showTimePicker,
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Choose Time",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
            ),

            MaterialButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PayUserScreen()));
                },
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
// ignore: file_names
// ignore_for_file: unused_import

import 'package:beverage_project/page/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PickTimeScreen extends StatefulWidget {
  const PickTimeScreen({Key? key}) : super(key: key);

  @override
  State<PickTimeScreen> createState() => _PickTimeScreenState();
}

class _PickTimeScreenState extends State<PickTimeScreen> {

  //create datetime variable
  String _getTime = "";
  String _date = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  //TimeOfDay _timeOfDay = TimeOfDay.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // String temp = "";

  // List<String> data_spit = _getTime.split(" ");
  // @override
  // void initState() {
  //   super.initState();
  //   // _getTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   // _timeOfDay = TimeOfDay.now();
  // }
  //String _gettimeOfDay = DateFormat('HH:mm:ss').format();
  //show date picker method

  // ignore: non_constant_identifier_names
  // void _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2022),
  //     lastDate: DateTime(2025),
  //   ).then((value) {
  //     setState(() {
  //       _date = value!;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _getTime =  DateFormat('yyyy-MM-dd').format(DateTime.now());
    List<String> dataSplit =  _getTime.split(" ");

    setState(() {
      _getTime = dataSplit[0];
        });
    
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // void _showTimePicker() {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   ).then((value) {
  //     setState(() {
  //       _timeOfDay = value!;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat.Hm().format(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "เวลาที่สั่งซื้อ\n $_date",
                style: GoogleFonts.kanit(
                  fontSize: 20,
                ),
              ),

            SizedBox(height: 10,),

            // Text(
            //   "เวลาที่ต้องการรับ\n ${_getTime} ${_timeOfDay.format(context).toString()}",
            //   style: GoogleFonts.kanit(
            //     fontSize: 20,
            //   ),
            // ),

            Text(
              'เวลาที่ต้องการรับ\n $_getTime $formattedTime',
              style: GoogleFonts.kanit(
                    fontSize: 20,
              ),
            ),

            // Text(
            //   _timeOfDay.format(context).toString(),
            //   style: const TextStyle(
            //     fontSize: 20,
            //   ),
            // ),

            MaterialButton(
                onPressed: () => _selectTime(context),
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

            Text(
              "ราคารวม ${Get.arguments["total"]} บาท",
              style: GoogleFonts.kanit(
                fontSize: 20,
              ),
            ),

            MaterialButton(
                onPressed: () {
                  Get.to(() => PayUserScreen(),
                      arguments: {
                        "total" : Get.arguments["total"],
                        "byTime" : _date,
                        "getTime" : "$_getTime $formattedTime"
                        //"getTime" : "${_getTime} ${_timeOfDay.format(context).toString()}",
                      }
                  );
                },
                // onPressed: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PayUserScreen()));
                //   print(_timeOfDay.format(context).toString());
                // },
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "จ่ายเงิน",
                    style: GoogleFonts.kanit(
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
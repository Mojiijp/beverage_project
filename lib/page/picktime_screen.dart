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
  //DateTime _dateNow = DateTime.now();
  String _date = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  TimeOfDay _selectedTime = TimeOfDay.now();

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
      backgroundColor: const Color(0xffEDF1D6),
      body: SafeArea(
        child: Column(
          children: [
            ///App bar
            Container(
              width: 500,
              height: 60,
              color: const Color(0xff609966),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios_outlined, size: 35,),
                      ),
                    ),
                    Text(
                      "เลือกเวลา",
                      style: GoogleFonts.kanit(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 130,),

            Text(
              "เวลาที่สั่งซื้อ\n $_date น.",
              style: GoogleFonts.kanit(
                fontSize: 28,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              'เวลาที่ต้องการรับ\n $_getTime $formattedTime น.',
              style: GoogleFonts.kanit(
                fontSize: 28,
              ),
            ),

            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff609966),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "เลือกเวลา",
                      style: GoogleFonts.kanit(
                        fontSize: 22,
                      ),
                    ),
                    Icon(Icons.done,)
                  ],
                ),
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "ราคารวม ${Get.arguments["total"]} บาท",
              style: GoogleFonts.kanit(
                fontSize: 28,
              ),
            ),

            SizedBox(height: 10,),

            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff609966),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "จ่ายเงิน",
                      style: GoogleFonts.kanit(
                        fontSize: 22,
                      ),
                    ),
                    Icon(Icons.done,)
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
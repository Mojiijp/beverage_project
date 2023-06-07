import 'dart:convert';

import 'package:beverage_project/src/model/noti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  _NotiScreenState createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Noti>> orderConfirm() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/menu/noti_histor'),
        headers: ({
          'Authorization': 'Bearer ${prefs.getString("token")}'
        })
    );

    print("status code is : ${response.statusCode}");


    if(response.statusCode == 200) {
      print("Load order in confirm success");


      List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);

      return data.map((item) => Noti.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      "ประวัติการแจ้งเตือน",
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

            FutureBuilder<List<Noti>>(
              future: orderConfirm(),
              builder: (BuildContext context, AsyncSnapshot<List<Noti>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // แสดงการโหลดข้อมูล
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  print(snapshot.data);
                  print(snapshot);
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}'); // แสดงข้อผิดพลาด
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: Center(
                          child: Text(
                            "ยังไม่มีเครื่องดื่มในตะกร้า\n กรุณาเลือกเครื่องดื่ม",
                            style: GoogleFonts.kanit(
                                fontSize: 22
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        height: 580,
                        child: Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final noti = snapshot.data![index];
                              return Column(
                                children: [
                                  //Text('Menu ID: ${menu.id}'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 100,
                                      width: 390,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.blueAccent
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${noti.id}',
                                            style: GoogleFonts.kanit(
                                                fontSize: 20
                                            ),
                                          ),
                                          Text(
                                            'รายละเอียด : ${noti.content}',
                                            style: GoogleFonts.kanit(
                                                fontSize: 20
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}

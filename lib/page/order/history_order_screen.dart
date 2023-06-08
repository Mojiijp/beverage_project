import 'dart:convert';
import 'package:beverage_project/page/order/history_order2.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/history.dart';
import 'package:http/http.dart' as http;
import 'package:beverage_project/src/model/order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({Key? key}) : super(key: key);

  @override
  State<HistoryOrderScreen> createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<Order>> fetchHistory() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/menu/order_histor_by_user'),
        headers: ({
          'Authorization': 'Bearer ${prefs.getString("token")}'
        })
    );

    print("status code is : ${response.statusCode}");

    if(response.statusCode == 200) {
      print("Load history success");

      List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);

      return data.map((item) => Order.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  final List size = ["","M","L"];
  final List sugar = ["ไม่หวาน","น้อย","ปานกลาง","ปกติ","มาก"];

  bool _isShow = true;

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
                      "ประวัติการสั่งซื้อ",
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

            Container(
              height: 700,
              child: FutureBuilder<List<Order>>(
                future: fetchHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // แสดงการโหลดข้อมูล
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      children: [
                        Center(
                          child: Text(
                            "ยังไม่มีสรุปคำสั่งซื้อในตอนนี้\n กรุณาสั่งซื้อเครื่องดื่มให้สำเร็จ",
                            style: GoogleFonts.kanit(
                                fontSize: 22
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 230,),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              //Get.toNamed(Routes.historyScreen);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  HistoryOrderScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff609966),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "ดูประวัติการสั่งซื้อ",
                                  style: GoogleFonts.kanit(
                                    fontSize: 20,
                                  ),
                                ),
                                Icon(Icons.done,)
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final menu = snapshot.data![index];
                        int id = menu.id;
                        double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const HistoryOrderScreen2(),
                                    arguments: {
                                      "id" : menu.id,
                                    }
                                );
                                print("Tap history");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(
                                  height: 140,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff9DC08B),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            'เลขที่คำสั่งซื้อ : ${menu.id}',
                                          style: GoogleFonts.kanit(
                                            fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          'วันเวลาที่สั่งซื้อ : ${menu.buyAt}',
                                          style: GoogleFonts.kanit(
                                              fontSize: 20
                                          ),
                                        ),
                                        Text(
                                          'วันเวลาที่ต้องการรับ : ${menu.getAt}',
                                          style: GoogleFonts.kanit(
                                              fontSize: 20
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }
}

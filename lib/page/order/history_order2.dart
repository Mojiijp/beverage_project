import 'dart:convert';

import 'package:beverage_project/src/model/history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryOrderScreen2 extends StatefulWidget {
  const HistoryOrderScreen2({Key? key}) : super(key: key);

  @override
  State<HistoryOrderScreen2> createState() => _HistoryOrderScreen2State();
}

class _HistoryOrderScreen2State extends State<HistoryOrderScreen2> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  historyOrder() async {
    final SharedPreferences prefs = await _prefs;

    var headers = {
      'Authorization': 'Bearer ${prefs.getString("token")}'
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.6:8000/api/menu/order_histor_by_id')
    );

    request.fields.addAll({
      'order_id': ''
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
    // final response = await http.post(
    //     Uri.parse('http://192.168.1.6:8000/api/menu/order_histor_by_user'),
    //     headers: ({
    //       'Authorization': 'Bearer ${prefs.getString("token")}'
    //     })
    // );
    //
    // print("status code is : ${response.statusCode}");
    //
    // if(response.statusCode == 200) {
    //   print("Load history by id success");
    //
    //   List<dynamic> jsonResponse = json.decode(response.body);
    //   List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);
    //
    //   return data.map((item) => Order.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load data');
    // }
  }

  Future<List<Order>> orderHistory() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
        Uri.parse('http://192.168.1.6:8000/api/menu/order_histor_by_id'),
        headers: ({
          'Authorization': 'Bearer ${prefs.getString("token")}'
        }),
        body: ({
          'order_id': '${id}'
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

  int id = 0;

  @override
  void initState() {
    setState(() {
      id = Get.arguments['id'];
    });

    super.initState();
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

            // FutureBuilder(
            //   future: historyOrder(),
            //   builder: (context, snapshot) {
            //     if(snapshot.hasData) {
            //       return Text("Hiiiiiiiiiii");
            //     } else if(snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }
            //     return Text("No Data");
            //   }
            //
            // )

            Container(
              height: 700,
              child: FutureBuilder<List<Order>>(
                future: orderHistory(),
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
                            onPressed: () {},
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
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                height: 120,
                                width: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.pink,
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
                            Container(
                              height:500,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: menu.menuDetail.length,
                                  itemBuilder: (context, index) {
                                    //double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
                                    final menuDetail = menu.menuDetail[index];
                                    final mixBevID = menuDetail.id;
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Image(
                                                        width: 100,
                                                        height: 100,
                                                        image: NetworkImage('http://192.168.1.6:8000/api/menu/image/${menuDetail.bevInfo.id}')
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          menuDetail.bevInfo.name,
                                                          //Get.arguments["name"],
                                                          style: GoogleFonts.kanit(
                                                              fontSize: 28,
                                                              color: Colors.black
                                                          ),
                                                        ),
                                                        Text(
                                                          "${menuDetail.price} บาท",
                                                          style: GoogleFonts.kanit(
                                                              fontSize: 28,
                                                              color: Colors.green
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: Colors.green
                                                          ),
                                                          child: Text(
                                                            "1",
                                                            //Get.arguments["amount"].toString(),
                                                            style: GoogleFonts.mulish(
                                                              fontSize: 28,
                                                              color: Colors.black,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "ขนาดแก้ว : ${size[menuDetail.size]}",
                                                        //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
                                                        style: GoogleFonts.kanit(
                                                            fontSize: 18,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                      Text(
                                                        "Topping : ${menuDetail.bevToppingAddInfo.join(",")}",
                                                        style: GoogleFonts.kanit(
                                                            fontSize: 18,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                      Text(
                                                        "ระดับความหวาน : ${sugar[menuDetail.sweetness]}",
                                                        style: GoogleFonts.kanit(
                                                            fontSize: 18,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    );
                                  }
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
        ),
      ),
    );
  }
}

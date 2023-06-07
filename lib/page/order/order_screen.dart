import 'dart:convert';

import 'package:beverage_project/page/order/history_order_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/order.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // ///API
  // Future<List<MyDataModel>> _getOrderInCart() async {
  //   final SharedPreferences prefs = await _prefs;
  //
  //   final response = await http.post(
  //       Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.orderInCart),
  //       headers: ({
  //         'Authorization': 'Bearer ${prefs.getString("token")}'
  //       })
  //   );
  //
  //   print("status code is : ${response.statusCode}");
  //
  //
  //   if(response.statusCode == 200) {
  //     print("Load order in cart success");
  //
  //
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);
  //
  //     return data.map((item) => MyDataModel.fromJson(item)).toList();
  //
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

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
                    ),
                    Text(
                      "สรุปคำสั่งซื้อ",
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

            SizedBox(height: 250,),

            SizedBox(
              height: 400,
              child: Column(
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
              ),
            ),

            // Container(
            //   height: 700,
            //   child: FutureBuilder<List<MyDataModel>> (
            //       future: _getOrderInCart(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return CircularProgressIndicator(); // แสดงการโหลดข้อมูล
            //         } else if (snapshot.hasError) {
            //           return Text('เกิดข้อผิดพลาด: ${snapshot.error}'); // แสดงข้อผิดพลาด
            //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //           return SizedBox(
            //             height: 650,
            //             child: Center(
            //               child: Text(
            //                 "ยังไม่มีสรุปคำสั่งซื้อในตอนนี้\n กรุณาสั่งซื้อเครื่องดื่มให้สำเร็จ",
            //                 style: GoogleFonts.kanit(
            //                     fontSize: 22
            //                 ),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //           );
            //         } else {
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               final menu = snapshot.data![index];
            //               int id = menu.id;
            //               double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
            //               return Column(
            //                 children: [
            //                   //Text('Menu ID: ${menu.id}'),
            //                   Container(
            //                     height: 510,
            //                     child: ListView.builder(
            //                         shrinkWrap: true,
            //                         itemCount: menu.menuDetail.length,
            //                         itemBuilder: (context, index) {
            //                           final menuDetail = menu.menuDetail[index];
            //                           final mixBevID = menuDetail.id;
            //                           return Padding(
            //                             padding: const EdgeInsets.all(5.0),
            //                             child: Column(
            //                               children: [
            //                                 Container(
            //                                   width: 500,
            //                                   height: 230,
            //                                   decoration: BoxDecoration(
            //                                       borderRadius: BorderRadius.circular(20),
            //                                       color: Colors.white
            //                                   ),
            //                                   child: Column(
            //                                     crossAxisAlignment: CrossAxisAlignment.stretch,
            //                                     children: [
            //                                       Text(
            //                                         "ID: ${id}",
            //                                         //Get.arguments["name"],
            //                                         style: GoogleFonts.kanit(
            //                                             fontSize: 10,
            //                                             color: Colors.black
            //                                         ),
            //                                       ),
            //                                       Row(
            //                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                                         children: [
            //                                           Image(
            //                                               width: 100,
            //                                               height: 100,
            //                                               image: NetworkImage('http://192.168.1.6:8000/api/menu/image/${menuDetail.bevInfo.id}')
            //                                           ),
            //                                           Column(
            //                                             children: [
            //                                               Text(
            //                                                 menuDetail.bevInfo.name,
            //                                                 //Get.arguments["name"],
            //                                                 style: GoogleFonts.kanit(
            //                                                     fontSize: 28,
            //                                                     color: Colors.black
            //                                                 ),
            //                                               ),
            //                                               Text(
            //                                                 "รวม ${menuDetail.price} บาท",
            //                                                 style: GoogleFonts.kanit(
            //                                                     fontSize: 28,
            //                                                     color: Colors.green
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           Column(
            //                                             children: [
            //                                               Container(
            //                                                 width: 30,
            //                                                 height: 30,
            //                                                 decoration: BoxDecoration(
            //                                                     borderRadius: BorderRadius.circular(5),
            //                                                     color: Colors.green
            //                                                 ),
            //                                                 child: Text(
            //                                                   "1",
            //                                                   //Get.arguments["amount"].toString(),
            //                                                   style: GoogleFonts.mulish(
            //                                                     fontSize: 28,
            //                                                     color: Colors.black,
            //                                                   ),
            //                                                   textAlign: TextAlign.center,
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           )
            //                                         ],
            //                                       ),
            //                                       Padding(
            //                                         padding: const EdgeInsets.all(8.0),
            //                                         child: Column(
            //                                           crossAxisAlignment: CrossAxisAlignment.start,
            //                                           children: [
            //                                             Text(
            //                                               "ID : ${menuDetail.id}",
            //                                               //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 10,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "ขนาดแก้ว : ${menuDetail.size}",
            //                                               //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "Topping : ${menuDetail.bevToppingAddInfo.join(",")}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "ระดับความหวาน : ${menuDetail.sweetness}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       )
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "เวลาที่สั่งซื้อ : ${Get.arguments["byTime"]}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 18,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "เวลาที่ต้องการรับ : ${Get.arguments["getTime"]}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 18,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                                 Center(
            //                                   child: SizedBox(
            //                                     height: 200, width: 200,
            //                                     child: Image.file(Get.arguments["slipImage"]),
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "ไฟล์ : ${menu.slipImgPath}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 10,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         }
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //                   Container(
            //                     //margin: const EdgeInsets.only(top: 5),
            //                     //padding: const EdgeInsets.all(20),
            //                     decoration: const BoxDecoration(
            //                       borderRadius: BorderRadius.only(
            //                         topLeft: Radius.circular(55),
            //                         topRight: Radius.circular(55),
            //                       ),
            //                       color: Colors.white,
            //                     ),
            //                     child: Column(
            //                       children: [
            //                         const SizedBox(height: 40,),
            //                         ///Text
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                           children: [
            //                             Text(
            //                               "ราคารวม",
            //                               style: GoogleFonts.kanit(
            //                                   fontSize: 26
            //                               ),
            //                             ),
            //
            //                             Text(
            //                               //"200 บาท",
            //                               "${totalPrice} บาท",
            //                               style: GoogleFonts.kanit(
            //                                   fontSize: 26,
            //                                   color: Color(0xff1C6B00)
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //
            //                         const SizedBox(height: 20,),
            //
            //                         ///submit button and select time
            //                         SizedBox(
            //                           width: 200,
            //                           height: 40,
            //                           child: ElevatedButton(
            //                             onPressed: () {},
            //                             style: ElevatedButton.styleFrom(
            //                               backgroundColor: Color(0xff609966),
            //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //                             ),
            //                             child: Row(
            //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                               children: [
            //                                 Text(
            //                                   "ยืนยันการสั่งซื้อ",
            //                                   style: GoogleFonts.kanit(
            //                                     fontSize: 20,
            //                                   ),
            //                                 ),
            //                                 Icon(Icons.done,)
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //
            //                         const SizedBox(height: 20,),
            //                       ],
            //                     ),
            //                   ),
            //                   //SizedBox(height: 10,)
            //                 ],
            //               );
            //             },
            //           );
            //         }
            //
            //         if (snapshot.hasData) {
            //           // แสดงผลในกรณีที่มีข้อมูล
            //           return ListView.builder(
            //             itemCount: snapshot.data!.length,
            //             itemBuilder: (context, index) {
            //               final menu = snapshot.data![index];
            //               int id = menu.id;
            //               double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
            //               return Column(
            //                 children: [
            //                   //Text('Menu ID: ${menu.id}'),
            //                   Container(
            //                     height: 510,
            //                     child: ListView.builder(
            //                         shrinkWrap: true,
            //                         itemCount: menu.menuDetail.length,
            //                         itemBuilder: (context, index) {
            //                           final menuDetail = menu.menuDetail[index];
            //                           final mixBevID = menuDetail.id;
            //                           return Padding(
            //                             padding: const EdgeInsets.all(5.0),
            //                             child: Column(
            //                               children: [
            //                                 Container(
            //                                   width: 500,
            //                                   height: 230,
            //                                   decoration: BoxDecoration(
            //                                       borderRadius: BorderRadius.circular(20),
            //                                       color: Colors.white
            //                                   ),
            //                                   child: Column(
            //                                     crossAxisAlignment: CrossAxisAlignment.stretch,
            //                                     children: [
            //                                       Text(
            //                                         "ID: ${id}",
            //                                         //Get.arguments["name"],
            //                                         style: GoogleFonts.kanit(
            //                                             fontSize: 10,
            //                                             color: Colors.black
            //                                         ),
            //                                       ),
            //                                       Row(
            //                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //                                         children: [
            //                                           Image(
            //                                               width: 100,
            //                                               height: 100,
            //                                               image: NetworkImage('http://192.168.1.6:8000/api/menu/image/${menuDetail.bevInfo.id}')
            //                                           ),
            //                                           Column(
            //                                             children: [
            //                                               Text(
            //                                                 menuDetail.bevInfo.name,
            //                                                 //Get.arguments["name"],
            //                                                 style: GoogleFonts.kanit(
            //                                                     fontSize: 28,
            //                                                     color: Colors.black
            //                                                 ),
            //                                               ),
            //                                               Text(
            //                                                 "รวม ${menuDetail.price} บาท",
            //                                                 style: GoogleFonts.kanit(
            //                                                     fontSize: 28,
            //                                                     color: Colors.green
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           ),
            //                                           Column(
            //                                             children: [
            //                                               Container(
            //                                                 width: 30,
            //                                                 height: 30,
            //                                                 decoration: BoxDecoration(
            //                                                     borderRadius: BorderRadius.circular(5),
            //                                                     color: Colors.green
            //                                                 ),
            //                                                 child: Text(
            //                                                   "1",
            //                                                   //Get.arguments["amount"].toString(),
            //                                                   style: GoogleFonts.mulish(
            //                                                     fontSize: 28,
            //                                                     color: Colors.black,
            //                                                   ),
            //                                                   textAlign: TextAlign.center,
            //                                                 ),
            //                                               ),
            //                                             ],
            //                                           )
            //                                         ],
            //                                       ),
            //                                       Padding(
            //                                         padding: const EdgeInsets.all(8.0),
            //                                         child: Column(
            //                                           crossAxisAlignment: CrossAxisAlignment.start,
            //                                           children: [
            //                                             Text(
            //                                               "ID : ${menuDetail.id}",
            //                                               //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 10,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "ขนาดแก้ว : ${menuDetail.size}",
            //                                               //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "Topping : ${menuDetail.bevToppingAddInfo.join(",")}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               "ระดับความหวาน : ${menuDetail.sweetness}",
            //                                               style: GoogleFonts.kanit(
            //                                                   fontSize: 18,
            //                                                   color: Colors.black
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       )
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "เวลาที่สั่งซื้อ : ${Get.arguments["byTime"]}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 18,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "เวลาที่ต้องการรับ : ${Get.arguments["getTime"]}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 18,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                                 Center(
            //                                   child: SizedBox(
            //                                     height: 200, width: 200,
            //                                     child: Image.file(Get.arguments["slipImage"]),
            //                                   ),
            //                                 ),
            //                                 Text(
            //                                   "ไฟล์ : ${menu.slipImgPath}",
            //                                   //"ระดับความหวาน : ${Get.arguments["sweet"]}",
            //                                   style: GoogleFonts.kanit(
            //                                       fontSize: 10,
            //                                       color: Colors.black
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           );
            //                         }
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //                   Container(
            //                     //margin: const EdgeInsets.only(top: 5),
            //                     //padding: const EdgeInsets.all(20),
            //                     decoration: const BoxDecoration(
            //                       borderRadius: BorderRadius.only(
            //                         topLeft: Radius.circular(55),
            //                         topRight: Radius.circular(55),
            //                       ),
            //                       color: Colors.white,
            //                     ),
            //                     child: Column(
            //                       children: [
            //                         const SizedBox(height: 40,),
            //                         ///Text
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                           children: [
            //                             Text(
            //                               "ราคารวม",
            //                               style: GoogleFonts.kanit(
            //                                   fontSize: 26
            //                               ),
            //                             ),
            //
            //                             Text(
            //                               //"200 บาท",
            //                               "${totalPrice} บาท",
            //                               style: GoogleFonts.kanit(
            //                                   fontSize: 26,
            //                                   color: Color(0xff1C6B00)
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //
            //                         const SizedBox(height: 20,),
            //
            //                         ///submit button and select time
            //                         SizedBox(
            //                           width: 200,
            //                           height: 40,
            //                           child: ElevatedButton(
            //                             onPressed: () {},
            //                             style: ElevatedButton.styleFrom(
            //                               backgroundColor: Color(0xff609966),
            //                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            //                             ),
            //                             child: Row(
            //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                               children: [
            //                                 Text(
            //                                   "ยืนยันการสั่งซื้อ",
            //                                   style: GoogleFonts.kanit(
            //                                     fontSize: 20,
            //                                   ),
            //                                 ),
            //                                 Icon(Icons.done,)
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //
            //                         const SizedBox(height: 20,),
            //                       ],
            //                     ),
            //                   ),
            //                   //SizedBox(height: 10,)
            //                 ],
            //               );
            //             },
            //           );
            //         } else if (snapshot.hasError) {
            //           // แสดงผลในกรณีที่เกิดข้อผิดพลาด
            //           return Text('Error: ${snapshot.error}');
            //         } else {
            //           // แสดงผลในระหว่างโหลดข้อมูล
            //           return Center(
            //             child: Text(
            //               "ไม่มีสรุปคำสั่งซื้อ",
            //               style: GoogleFonts.kanit(
            //                   fontSize: 20
            //               ),
            //             ),
            //           );
            //         }
            //       }
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}

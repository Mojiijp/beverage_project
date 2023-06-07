import 'dart:convert';

import 'package:beverage_project/page/menu/detail_screen.dart';
import 'package:beverage_project/page/pay_screen.dart';
import 'package:beverage_project/page/picktime_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/order.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<MyDataModel>> _getOrderInCart() async {
    final SharedPreferences prefs = await _prefs;

    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.orderInCart),
      headers: ({
        'Authorization': 'Bearer ${prefs.getString("token")}'
      })
    );

    print("status code is : ${response.statusCode}");


    if(response.statusCode == 200) {
      print("Load order in cart success");
      print(response.body);

      List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);

      return data.map((item) => MyDataModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  deleteOrder(int mixBevID) async {
    final SharedPreferences prefs = await _prefs;

    var headers = {
      'Authorization': 'Bearer ${prefs.getString("token")}'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.6:8000/api/menu/del_item_in_cart'));
    request.fields.addAll({
      'mixbev_id': '$mixBevID'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("status delete is : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Delete item success");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
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
                        icon: const Icon(Icons.arrow_back_ios_rounded, size: 35,),
                      ),
                    ),
                    Text(
                      "My Cart",
                      style: GoogleFonts.mulish(
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

            // SizedBox(
            //   height: 250,
            // ),

            Container(
              height: 720,
              color: Color(0xffEDF1D6),
              //color: Colors.pink,
              child: FutureBuilder<List<MyDataModel>> (
                future: _getOrderInCart(),
                builder: (BuildContext context, AsyncSnapshot<List<MyDataModel>> snapshot) {
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
                        Container(
                          height: 220,
                          //margin: const EdgeInsets.only(top: 5),
                          //padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(55),
                              topRight: Radius.circular(55),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30,),
                              ///Text
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "ราคารวม",
                                    style: GoogleFonts.kanit(
                                        fontSize: 26
                                    ),
                                  ),

                                  Text(
                                    "0 บาท",
                                    //"${totalPrice} บาท",
                                    style: GoogleFonts.kanit(
                                        fontSize: 26,
                                        color: Color(0xff1C6B00)
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30,),

                              ///submit button and select time
                              SizedBox(
                                width: 200,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.bottomNavBar);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff609966),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "สั่งเครื่องดื่ม",
                                        style: GoogleFonts.kanit(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Icon(Icons.done,)
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final menu = snapshot.data![index];
                        double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
                        return Column(
                          children: [
                            //Text('Menu ID: ${menu.id}'),
                            Container(
                              height: 510,
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
                                            width: 500,
                                            height: 240,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                // Text(
                                                //   "ID: ${menu.id}",
                                                //   //Get.arguments["name"],
                                                //   style: GoogleFonts.kanit(
                                                //       fontSize: 10,
                                                //       color: Colors.black
                                                //   ),
                                                // ),
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
                                                        IconButton(
                                                          onPressed: () {
                                                            deleteOrder(mixBevID);
                                                            print("Delete");
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                            size: 30,
                                                          ),
                                                        ),
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
                                                      // Text(
                                                      //   "ID : ${menuDetail.id}",
                                                      //   //"ขนาดแก้ว : ${Get.arguments["sizeCup"]}",
                                                      //   style: GoogleFonts.kanit(
                                                      //       fontSize: 10,
                                                      //       color: Colors.black
                                                      //   ),
                                                      // ),
                                                      Text(
                                                        "ขนาดแก้ว : ${menuDetail.size}",
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
                                                        "ระดับความหวาน : ${menuDetail.sweetness}",
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
                            Container(
                              //margin: const EdgeInsets.only(top: 5),
                              //padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(55),
                                  topRight: Radius.circular(55),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  ///Text
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "ราคารวม",
                                        style: GoogleFonts.kanit(
                                            fontSize: 26
                                        ),
                                      ),

                                      Text(
                                        //"200 บาท",
                                        "${totalPrice} บาท",
                                        style: GoogleFonts.kanit(
                                            fontSize: 26,
                                            color: Color(0xff1C6B00)
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20,),

                                  ///submit button and select time
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => PickTimeScreen(),
                                            arguments: {
                                              "total" : totalPrice
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
                                            "เลือกเวลารับ",
                                            style: GoogleFonts.kanit(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Icon(Icons.done,)
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),

                                  ///Add order button
                                  SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed:() {
                                        Get.toNamed(Routes.bottomNavBar);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Color(0xffa8cea8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                          side: const BorderSide(
                                            width: 1,
                                            color: Color(0xff609966),
                                          )
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "เพิ่มรายการ",
                                            style: GoogleFonts.kanit(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Icon(Icons.add)
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 30,),
                                ],
                              ),
                            ),
                            //SizedBox(height: 10,)
                          ],
                        );
                      },
                    );
                  }
                }
              )
            ),
          ],
        )
      ),
    );
  }
}

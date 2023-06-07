import 'dart:convert';

import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/order.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


///API
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final List size = ["","M","L"];
  final List sugar = ["ไม่หวาน","น้อย","ปานกลาง","ปกติ","มาก"];
  String get_at ="";
  String buy_at ="";
  String image_name ="";
  @override
  
  void initState() {
    super.initState();
  setState(() {
    get_at = Get.arguments['getTime'];
    buy_at = Get.arguments['byTime'];
    image_name = Get.arguments['imageName'];
    });
    // _getOrderInCart();
  }




orderInConf(double totalPrice, int id) async {
  final SharedPreferences prefs = await _prefs;

  var headers = {
    'Authorization': 'Bearer ${prefs.getString("token")}'
  };

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.1.6:8000/api/menu/order_in_conf')
  );

  request.fields.addAll({
    'buy_at': '${buy_at}',
    'get_at': '${get_at}',
    'amount': '1',
    'total_price': '${totalPrice}',
    'id': '${id}'
  });

  request.files.add(
      await http.MultipartFile.fromPath(
        'slip_img',
        '${image_name}',
        //'/data/user/0/com.example.beverage_project/cache/file_picker/79a45824db0bd561642f5c7d2c6d1000.jpg'
    )
  );
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  print(response.statusCode);

  if (response.statusCode == 200) {
    print("Upload success");
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

}




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


      List<dynamic> jsonResponse = json.decode(response.body);
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(jsonResponse);

      return data.map((item) => MyDataModel.fromJson(item)).toList();



      //return MyDataModel.fromJson(jsonDecode(response.body));


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
                          icon: const Icon(Icons.arrow_back_ios_rounded, size: 35,),
                        ),
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

              // SizedBox(
              //   height: 250,
              // ),

              Container(
                  height: 720,
                  color: Color(0xffEDF1D6),
                  //color: Colors.pink,
                  child: FutureBuilder<List<MyDataModel>> (
                      future: _getOrderInCart(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // แสดงผลในกรณีที่มีข้อมูล
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final menu = snapshot.data![index];
                              int id = menu.id;
                              double totalPrice = menu.menuDetail.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));
                              return Column(
                                children: [
                                  //Text('Menu ID: ${menu.id}'),
                                  Container(
                                    height: 300,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: menu.menuDetail.length,
                                        itemBuilder: (context, index) {
                                          final menuDetail = menu.menuDetail[index];
                                          final mixBevID = menuDetail.id;
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              width: 300,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.white
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  // Text(
                                                  //   "ID: ${id}",
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
                                          );
                                        }
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "เวลาที่สั่งซื้อ : ${buy_at}",
                                          //"ระดับความหวาน : ${Get.arguments["sweet"]}",
                                          style: GoogleFonts.kanit(
                                              fontSize: 18,
                                              color: Colors.black
                                          ),
                                        ),
                                        Text(
                                          "เวลาที่ต้องการรับ : ${get_at}",
                                          //"ระดับความหวาน : ${Get.arguments["sweet"]}",
                                          style: GoogleFonts.kanit(
                                              fontSize: 18,
                                              color: Colors.black
                                          ),
                                        ),
                                        Center(
                                          child: SizedBox(
                                            height: 100, width: 100,
                                            child: Image.file(Get.arguments["slipImage"]),
                                          ),
                                        ),
                                        Text(
                                          "ไฟล์ : ${image_name}",
                                          //"ระดับความหวาน : ${Get.arguments["sweet"]}",
                                          style: GoogleFonts.kanit(
                                              fontSize: 10,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10,),
                                  Container(
                                    height: 200,
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
                                        const SizedBox(height: 40,),
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
                                              orderInConf(totalPrice, id);
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
                                                  "ยืนยันการสั่งซื้อ",
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
                                  //SizedBox(height: 10,)
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          // แสดงผลในกรณีที่เกิดข้อผิดพลาด
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // แสดงผลในระหว่างโหลดข้อมูล
                          return Center(
                            child: Text(
                              "ไม่มีสรุปคำสั่งซื้อ",
                              style: GoogleFonts.kanit(
                                  fontSize: 20
                              ),
                            ),
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


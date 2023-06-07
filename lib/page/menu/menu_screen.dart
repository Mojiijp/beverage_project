import 'dart:convert';

import 'package:beverage_project/page/basket_screen.dart';
import 'package:beverage_project/page/menu/detail_screen.dart';
import 'package:beverage_project/page/menu/list_menu.dart';
import 'package:beverage_project/page/order/order_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/model/status.dart';
import 'package:beverage_project/src/services/menu_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  openClose() async {
    var request = http.Request('GET', Uri.parse('http://192.168.1.6:8000/api/setting/get_last_status'));

    http.StreamedResponse response = await request.send();

    print("status code is : ${response.statusCode}");

    if (response.statusCode == 200) {
      print("Load status open-close success");
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<Status> status() async {
    // URL ของ API ที่ต้องการเรียกใช้งาน
    var url = Uri.parse('http://192.168.1.6:8000/api/setting/get_last_status'); // แทนที่ด้วย URL จริงของ API

    // เรียก API ด้วยเมธอด GET
    var response = await http.get(url);

    // ตรวจสอบสถานะของการเรียก API
    if (response.statusCode == 200) {
      // แปลง JSON เป็น MyModel object
      var jsonData = json.decode(response.body);
      var status = Status.fromJson(jsonData);
      return status;
    } else {
      // ถ้าการเรียก API ไม่สำเร็จ ให้ส่งข้อมูลที่ไม่ครบถ้วนกลับไป
      throw Exception('Failed to load data');
    }
  }

  Future<List<Menu>>? menuTea;

  bool _isShow = false;
  bool _isShow2 = false;
  bool _isShow3 = false;

  @override
  void initState() {
    print("initState");
    //menuTea = MenuService().fetchMenu();
    //menuController.fetchMenu();
    super.initState();
  }

  void _refreshData(){
    setState(() {
      print("setState"); // สำหรับทดสอบ
      //menuTea = fetchMenu();
    });
  }

  //final menuController = Get.put(MenuController1());

  late Widget myWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1D6),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App bar menu
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
                      "Menu",
                      style: GoogleFonts.mulish(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications, size: 35,),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder<Status>(
              future: status(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // ถ้าข้อมูลถูกดึงมาสำเร็จ
                  var myModel = snapshot.data!;
                  // เช็คค่า status เพื่อกำหนด Widget และสีพื้นหลังที่แตกต่างกัน
                  if (myModel.status == 1) {
                    myWidget = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Title
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Text(
                              "Our",
                              style: GoogleFonts.mulish(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                          ),
                          ///Title 2
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Menu",
                              style: GoogleFonts.mulish(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                          ),

                          ///Grid View
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children : [
                                  ///Fruits tea
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          print("Click");
                                          setState(() {
                                            _isShow = !_isShow;
                                          },
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return  const ListMenu(3);
                                                },
                                              )
                                          );
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(top: 3),
                                                child: Image(
                                                  image: AssetImage("assets/apple_tea.png"),
                                                ),
                                              ),
                                              Text(
                                                "ชาผลไม้",
                                                style: GoogleFonts.kanit(
                                                    fontSize: 16,
                                                    //fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  ///Milks tea
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          print("Click");
                                          setState(
                                                () {
                                              _isShow2 = !_isShow2;
                                            },
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return  const ListMenu(2);
                                                },
                                              )
                                          );
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              const Image(
                                                image: AssetImage("assets/milk_tea.png"),
                                              ),
                                              Text(
                                                "ชานม",
                                                style: GoogleFonts.kanit(
                                                    fontSize: 16,
                                                    //fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  ///Healthy tea
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          print("Click");
                                          setState(
                                                () {
                                              _isShow3 = !_isShow3;
                                            },
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return  const ListMenu(1);
                                                },
                                              )
                                          );
                                        },
                                        child: Container(
                                          width: 140,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(top: 8),
                                                child: Image(
                                                  image: AssetImage("assets/ulong_tea.png"),
                                                ),
                                              ),
                                              Text(
                                                "ชาเพื่อสุขภาพ",
                                                style: GoogleFonts.kanit(
                                                    fontSize: 16,
                                                    //fontWeight: FontWeight.bold,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ]
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      );
                  } else if (myModel.status == 0) {
                    myWidget = Center(
                      child: Text(
                        "ร้านปิดแล้วจ้า\n เจอกันวันหลังน้า",
                        style: GoogleFonts.kanit(
                            fontSize: 22
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return myWidget;
                } else if (snapshot.hasError) {
                  // ถ้าเกิดข้อผิดพลาดขณะดึงข้อมูล
                  return Text('Error: ${snapshot.error}');
                }// แสดงผลในระหว่างการดึงข้อมูล
                return Center(child: CircularProgressIndicator());
              },


                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return CircularProgressIndicator(); // แสดงการโหลดข้อมูล
                // } else if (snapshot.hasError) {
                //   print(snapshot.error);
                //   return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                //   return Center(
                //     child: Text(
                //       "ร้านปิดแล้วจ้า\n เจอกันวันหลังน้า",
                //       style: GoogleFonts.kanit(
                //           fontSize: 22
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   );
                // } else {
                //   return
                // }
              //},
            ),
          ]
        ),
      ),
      ///Basket
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff609966),
        foregroundColor: Colors.black,
        onPressed: () {
          Get.toNamed(Routes.basketScreen);
        },
        child: const Icon(Icons.shopping_basket),
      )
    );
  }
}

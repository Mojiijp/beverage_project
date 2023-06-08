import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/login.dart';
import 'package:beverage_project/src/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  //static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late bool _loginSuccess;
  User? _user;
  String? _email = '';
  String? _name = '';
  String? _phone = '';
  String _token = '';
  String _createdate = '';

  @override
  void initState() {
    super.initState();
    loadSettings(); // เรียกใช้งานตั้งค่าเมื่อเริ่มต้นเป็นฟังก์ชั่น ให้รองรับ async
  }

  // ตั้งค่าเริ่มต้น
  void loadSettings() async {
    _loginSuccess = await LoginService.getLoginStatus(); // ถึงสถานะการล็อกอิน ถ้ามี
    if(_loginSuccess){ // ถ้าล็อกอินอยู่
      fetchUser(); // ดึงข้อมูลของผู้ใช้ ถ้าล็อกอินอยู่
    }
  }

  // ฟังก์ชั่นสำหรับดึงข้อมูลผู้ใช้
  void fetchUser() async {
    setState(() {
      _loginSuccess = true;
    });

    _user = await LoginService.getUser();

    // ดึงข้อมูลทั่วไปของผู้ใช้
    _email = _user!.email;
    _name = _user!.name;
    _phone = _user!.phone_number;
    _token = _user!.token ?? '';
    // // ดึงข้อมูลเพิ่มเติมในฐานข้อมูลบน server
    // Map<String, dynamic> _userExt = await LoginService.get(_token);
    // _createdate = _userExt['user_cratedate'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1D6),
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Profile",
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

              ///Profile Box + Text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "โปรไฟล์ของฉัน",
                  style: GoogleFonts.kanit(
                    fontSize: 18,

                  ),
                ),
              ),

              FutureBuilder(
                future: LoginService.getLoginStatus(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return Center(
                      child: Container(
                            width: 370,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///name
                                  Text(
                                    "Username : $_name",
                                    style: GoogleFonts.mulish(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1C6B00)
                                    ),
                                  ),
                                  ///email
                                  Text(
                                    "E-mail : $_email",
                                    style: GoogleFonts.mulish(
                                        fontSize: 22,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                  ///phone
                                  Text(
                                    "Phone : $_phone",
                                    style: GoogleFonts.mulish(
                                        fontSize: 22,
                                        //fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    );
                  }
                  return Text("Error");
                },
              ),

              ///contact + text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ต่อต่อร้านค้า",
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                  ),
                ),
              ),

              Center(
                child: Container(
                  width: 370,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone
                        ),
                        Text(
                          "093 132 2003",
                          style: GoogleFonts.mulish(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              ///Facebook
              Center(
                child: Container(
                  width: 370,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.facebook
                        ),
                        Text(
                          "ถังชา : Thang Cha Little Garden",
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Center(
              //   child: Container(
              //     width: 370,
              //     height: 80,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.phone
              //           ),
              //           Text(
              //             "@661znkvt",
              //             style: GoogleFonts.kanit(
              //               fontSize: 18,
              //             ),
              //           ),
              //         ],
              //       )
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),

              Center(
                child: Container(
                  width: 370,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.map_rounded
                        ),
                        Text(
                          "ถนน มาลัยแมน ตำบลกำแพงแสน\n Amphoe Kamphaeng Saen,\n Thailand, Nakhon Pathom",
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),



              const SizedBox(
                height: 30,
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.loginScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    "Log out",
                    style: GoogleFonts.mulish(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )



          // Column(
          //   children: [
          //     Container(
          //       width: 500,
          //       height: 200,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(20)
          //       ),
          //       child: Text(
          //         "Email : $_email",
          //         style: GoogleFonts.mulish(
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.black
          //         ),
          //       ),
          //     ),
          //
          //     ///Log out
          //     Center(
          //       child: ElevatedButton(
          //         onPressed: () {
          //           Get.toNamed(Routes.loginScreen);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.red,
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          //         ),
          //         child: Text(
          //           "Log out",
          //           style: GoogleFonts.mulish(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
      ),
    );
  }
}

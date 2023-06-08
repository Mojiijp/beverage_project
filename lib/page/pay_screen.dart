// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, non_constant_identifier_names, deprecated_member_use, avoid_print

import 'dart:io';
import 'package:beverage_project/page/summary_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayUserScreen extends StatefulWidget {
  @override
  State<PayUserScreen> createState() => _PayUserScreenState();
}

class _PayUserScreenState extends State<PayUserScreen> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  // Upload(File imageFile) async {
  //   var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();
  //
  //   var uri = Uri.parse("http://192.168.1.10:8000/api/menu/order_in_conf");
  //
  //   var request = http.MultipartRequest("POST", uri);
  //   var multipartFile = http.MultipartFile(
  //       'file',
  //       stream,
  //       length,
  //       filename: basename(imageFile.path));
  //   //contentType: new MediaType('image', 'png'));
  //
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   print(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     print(value);
  //   });
  // }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  FileSelect() async {
    final SharedPreferences prefs = await _prefs;

    var headers = {
      'Authorization': 'Bearer ${prefs.getString("token")}',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.6:8000/api/menu/order_in_conf'));

    request.files.add(
      await http.MultipartFile.fromPath(
        'slip_img',
        //_fileName!
        '/data/user/0/com.example.beverage_project/cache/file_picker/cc8e8cb2172797409c52e1eecd25d43a.jpg'
      )
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("status code upload file is : ${response.statusCode}");

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }


  void pickFile() async {
    try{
      setState(() {
        isLoading = true;
      });

      var platform;
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if(result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('File name $_fileName');
        print(fileToDisplay);
        print(pickedFile);

      }

      setState(() {
        isLoading = false;
      });

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF1D6),
      body : SafeArea(
        child: SingleChildScrollView(
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
                        "ชำระเงิน",
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
                height: 1500,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "แสกน QR Code ได้เลยจ้า",
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                              ),
                            ),
                        )
                    ),

                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Image.network("https://promptpay.io/0852994229/${Get.arguments["total"]}")
                      //Image.asset("assets/qrcode.png")
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "ชื่อบัญชี : บจก.ถังชา",
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                              ),
                            ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "ราคา : ${Get.arguments["total"]} บาท",
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                              ),
                            ),
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "เวลาสั่งซื้อ : ${Get.arguments["byTime"]} น.",
                              //"เวลารับ : ${Get.arguments["time"]}",
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                              ),
                            )
                        )
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "เวลารับ : ${Get.arguments["getTime"]} น.",
                              //"เวลารับ : ${Get.arguments["time"]}",
                              style: GoogleFonts.kanit(
                                fontSize: 22,
                              ),
                            )
                        )
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 10),
                              child:  Center(
                                  child: Text(
                                    "แนบสลิปชำระเงิน",
                                    style: GoogleFonts.kanit(
                                      fontSize: 22,
                                    ),
                                  )
                              )
                          ),

                        ]
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  pickFile();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff609966),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "เลือกรูปภาพ",
                                      style: GoogleFonts.kanit(
                                        fontSize: 22,
                                      ),
                                    ),
                                    Icon(Icons.done,)
                                  ],
                                ),
                              ),
                          ),
                          if(pickedFile != null)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.file(fileToDisplay!),
                            ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => SummaryScreen(),
                                arguments: {
                                  "getTime" : Get.arguments["getTime"],
                                  "byTime" : Get.arguments["byTime"],
                                  "slipImage" : fileToDisplay!,
                                  "imageName" : pickedFile!.path.toString(),
                                  "total" : Get.arguments["total"]
                                }
                            );

                            print(pickedFile!.path.toString());

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff609966),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "ดูสรุปการสั่งซื้อ",
                                style: GoogleFonts.kanit(
                                  fontSize: 22,
                                ),
                              ),
                              Icon(Icons.done,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}


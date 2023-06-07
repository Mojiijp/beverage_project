// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, non_constant_identifier_names, deprecated_member_use, avoid_print

import 'dart:io';
import 'package:beverage_project/page/summary_screen.dart';
import 'package:get/get.dart';
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
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.5:8000/api/menu/order_in_conf'));

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
        appBar: AppBar(
            title: const Text("Pay Screen")),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Center(
                        child: Text(
                            "ช่องทางการชำระเงิน",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
                        )
                    )
                ),

                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Center(
                        child: Text(
                            "แสกน QRCode ได้เลยจ้า",
                            style: TextStyle(fontSize: 18)
                        )
                    )
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.network("https://promptpay.io/0852994229/${Get.arguments["total"]}")
                  //Image.asset("assets/qrcode.png")
                ),

                const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child:  Center(
                        child: Text(
                          "ธนาคารกสิกรไทย",
                          style: TextStyle(fontSize: 18, color: Colors.green),

                        )
                    )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "เลขที่บัญชี : 123456789",
                              style: TextStyle(
                                fontSize: 18,

                              ),
                            )
                        )
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "ชื่อบัญชี : บจก.ถังชา",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                        )
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "ราคา : ${Get.arguments["total"]}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                        )
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "เวลาสั่งซื้อ : ${Get.arguments["byTime"]}",
                              //"เวลารับ : ${Get.arguments["time"]}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                        )
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child:  Center(
                            child: Text(
                              "เวลารับ : ${Get.arguments["getTime"]}",
                              //"เวลารับ : ${Get.arguments["time"]}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                        )
                    ),
                  ],
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child:  Center(
                              child: Text(
                                "แนบสลิปชำระเงิน",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )
                          )
                      ),
                    ]
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                            onPressed: () {
                              pickFile();
                            },
                            child: Text("Pick File")


                        ),
                      ),
                      if(pickedFile != null)
                        SizedBox(
                          height: 400, width: 400,
                          child: Image.file(fileToDisplay!),
                        ),
                      // Center(
                      //   child: ElevatedButton(
                      //       onPressed: () async{
                      //         //await FileSelect();
                      //         //await Upload(fileToDisplay!);
                      //       },
                      //       child: Text("Upload File")
                      //   ),
                      // ),

                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return SummaryScreen();
                              //     },
                              //   ),
                              // );
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
                            child: Text("ดูสรุปการสั่งซื้อ")
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}


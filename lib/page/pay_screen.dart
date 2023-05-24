// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, non_constant_identifier_names, deprecated_member_use, avoid_print

import 'dart:io';
import 'package:flutter_application_3/model/menu.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Screens/Basket/receipt.dart';
import 'package:flutter_application_3/Screens/Order/Screen/detail_menu.dart';
class PayUserScreen extends StatefulWidget {
  final String id;
  final String date;
  final String time;
  final Menu milktea;
  const PayUserScreen(this.id,this.date,this.time,this.milktea);

  @override
  State<PayUserScreen> createState() => _PayUserScreenState();
}

class _PayUserScreenState extends State<PayUserScreen> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;
  Upload(File imageFile) async {
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://10.0.2.2:5000/upload/${sizecupSelect.last}/${toppingSelect.join(",")}/${sweetnessSelect.last}/${amontIncart}/${this.widget.id}");

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
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
                  child:  Image.network(
                    "https://scontent.fkdt1-1.fna.fbcdn.net/v/t1.15752-9/313379146_837895737660109_4715347241078870872_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=ae9488&_nc_eui2=AeEjUWgvdAuSuOKcsjTUJWy7miV59yUk6b2aJXn3JSTpvWsI4TC-ftfeLvJyh7uWmu6W_qN2GUk8z5qRgiDheOAy&_nc_ohc=mmXiUPlV8zwAX_oRdZz&_nc_ht=scontent.fkdt1-1.fna&oh=03_AdTBT0_c6CK6aCfMRHAEbPBUigzR-TWhCDnsmHAG3cwaYA&oe=638A2BC0",
                    height: 180,
                  ),

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
                              "ราคา : ${widget.milktea.menuPrice *amontIncart }",
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
                            onPressed: () {pickFile();},
                            child: Text("Pick File")
                        ),
                      ),
                      if(pickedFile != null)
                        SizedBox(
                          height: 400, width: 400,
                          child: Image.file(fileToDisplay!),
                        ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () async{
                              await Upload(fileToDisplay!);
                            },
                            child: Text("Upload File")
                        ),
                      ),

                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ReceiptScreen(this.widget.id,this.widget.date,this.widget.time,this.widget.milktea);
                                  },
                                ),
                              );
                            },
                            child: Text("Submit")
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


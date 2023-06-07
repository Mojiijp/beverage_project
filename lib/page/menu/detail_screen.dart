// ignore_for_file: unused_import, camel_case_types

import 'dart:ffi';

import 'package:beverage_project/page/basket_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/model/topping.dart';
import 'package:beverage_project/src/services/topping_service.dart';
import 'package:beverage_project/src/utils/api_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String> toppingSelect = [];
List<String> sizeCupSelect = [];
List<String> sweetnessSelect = [];

List topping_list = [];

int countSize = 0;
int countTopping = 0;
int amountInCart = 1;

///String to list
int cupSize = 0;
int sweetnessInt = 0;
int toppingInt = 0;
List<int> toppingIntSelect = [];

// String toppingString = toppingInt.toString(); // แปลงจำนวนเต็มเป็นสตริง
// List<String> topping = toppingString.split(''); // แยกสตริงออกเป็นตัวอักษรแต่ละตัว
//
// List<int> toppingList = topping.map((topping) => int.parse(topping)).toList(); // แปลงตัวอักษรแต่ละตัวในรายการเป็นจำนวนเต็ม
//
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


OrderIn() async {
  final SharedPreferences prefs = await _prefs;

  var headers = {
    'Authorization': 'Bearer ${prefs.getString("token")}'
  };

  //print(prefs.getString("token"));

  var request = http.MultipartRequest(
    'POST',
    Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndPoints.orderIn)
    //Uri.parse('http://192.168.1.10:8000/api/menu/order_in')
  );

  var size = cupSize;
  var sweetness = sweetnessInt;
  int bevId =  Get.arguments["id"];
  var toppingId = toppingIntSelect;

  request.fields.addAll({
    'mix_data': '[\n{\n "bev_id": $bevId,\n "sweetness": $sweetness,\n "size": $size,\n "topping_id": $toppingId\n }\n]\n'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  print(response.statusCode);

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}


class DetailScreen extends StatefulWidget {

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  dataStore() async {
    topping_list = await ToppingService().fetchTopping();
  }

  List<String> sizeCup = [
    "Size M",
    "Size L",
  ];

  List<String> sweetNess = [
    "ไม่หวาน",
    "หวานน้อย",
    "หวานปานกลาง",
    "หวานปกติ",
    "หวานมาก",
  ];

  @override
  void initState() {
    super.initState();

    dataStore();

    setState(() {
      toppingIntSelect = [];
      toppingSelect = [];
      countTopping = 0;
    });
    print(topping_list);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffEDF1D6),
        body: SafeArea(
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
                          "Detail",
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
          
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 400,
                        height: 260,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text(
                              "Id : ${Get.arguments["id"]}",
                              style: GoogleFonts.kanit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1C6B00)
                              ),
                            ),
                            Image(
                              image: NetworkImage(Get.arguments["image"]),
                              width: 150,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1C6B00)
                              ),
                            ),
                            Text(
                              "${Get.arguments["price"]} บาท",
                              //"$countSize บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1C6B00)
                              ),
                            ),
                            // Text(
                            //   "$countSize บาท + ราคาท็อปปิ้ง $countTopping บาท * จำนวน $amountInCart แก้ว",
                            //   style: GoogleFonts.kanit(
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color(0xff1C6B00)
                            //   ),
                            // ),
                            // Text(
                            //   "รวมราคาเครื่องดื่ม ${(countSize + countTopping) * amountInCart} บาท",
                            //   style: GoogleFonts.kanit(
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold,
                            //       color: Color(0xff1C6B00)
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _titleContainer("ขนาดแก้ว"),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          choiceChipWidget(sizeCup),
                        ],
                      ),
                      const Divider(color: Colors.blueGrey, height: 10.0),
          
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _titleContainer("Topping"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            children: <Widget>[
                              Container(
                                height: 200,
                                //width: 300,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 5/1.5,
                                    //mainAxisSpacing: 10,
                                    //crossAxisSpacing: 1
                                  ),
                                  itemCount: topping_list.length,
                                  itemBuilder: (context, index) {
                                    Topping topping = topping_list[index];

                                    return filterChipWidget(chipName: "${topping.name} + ${topping.price}");
                                  }
                                ),
                              ),
                            ],
          
                          ),
                        ),
                      ),
                      const Divider(color: Colors.blueGrey, height: 10.0),
          
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _titleContainer("ระดับความหวาน"),
                        ),
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: <Widget>[
                          choiceChipWidgetTwo(sweetNess),
                        ],
                      ),
                      const Divider(color: Colors.blueGrey, height: 10.0),
          
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: _titleContainer("จำนวน"),
                      //   ),
                      // ),
                      // const CartCounter(),
          
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // shape: Border.all(width: 5),
                            onPressed: ()
                            async
                            {
                              await OrderIn();
                              //Get.toNamed(Routes.basketScreen);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const BasketScreen()));
                              Get.to(() => const BasketScreen(),
                                  arguments: {
                                    "image" : Get.arguments["image"],
                                    "name" : Get.arguments["name"],
                                    "price" : Get.arguments["price"],
                                    "priceCal" : (countSize + countTopping) * amountInCart,
                                    "amount" : amountInCart,
                                    "sizeCup" : sizeCupSelect.last,
                                    "topping" : toppingSelect.join(","),
                                    "sweet" : sweetnessSelect.last
                                  }
                              );
                              print("Size cup : $cupSize");
                              //print("Topping : ${toppingSelect.join(",")}");
                              print("Topping : $toppingIntSelect");
                              print("Sweetness level : $sweetnessInt");
                              print("Price : ${(countSize + countTopping) * amountInCart}");
                            },
                            color: Color.fromRGBO(84, 180, 53, 10),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Add on Basket",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
          
                                  fontSize: 20,
                                ),
                              ),
                            )
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

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: GoogleFonts.kanit(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

///Topping
class filterChipWidget extends StatefulWidget {
  final String chipName;
  const filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  State<filterChipWidget> createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: const TextStyle(color: Color.fromRGBO(1, 1, 1, 70),
          fontSize: 16.0,
          fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
      ),
      backgroundColor: const Color(0xffffffff),
      onSelected: (isSelected) {
        isSelected?

        setState(() {
          toppingSelect.add(widget.chipName.split(" ")[0]);
          if(widget.chipName == "ไม่ใส่ท็อปปิ้ง + 0"){
            countTopping = countTopping + 0;
            toppingIntSelect.add(0);
            toppingInt = 0;
          }else if(widget.chipName == "ไข่มุก + 0"){
            countTopping = countTopping + 0;
            toppingIntSelect.add(1);
            toppingInt = 1;
          }else if(widget.chipName == "พุดดิ้ง + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(2);
            toppingInt = 2;
          }else if(widget.chipName == "เฉาก๊วย + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(3);
            toppingInt = 3;
          }else if(widget.chipName == "วุ้นลิ้นจี่ + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(4);
            toppingInt = 4;
          }else if(widget.chipName == "วุ้นแอปเปิ้ล + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(5);
            toppingInt = 5;
          }else if(widget.chipName == "วุ้นสตรอว์เบอร์รี่ + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(6);
            toppingInt = 6;
          }else if(widget.chipName == "บราวน์ชูการ์ + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(7);
            toppingInt = 7;
          }else if(widget.chipName == "น้ำผึ้ง + 5"){
            countTopping = countTopping + 5;
            toppingIntSelect.add(8);
            toppingInt = 8;
          }else if(widget.chipName == "บราวน์ชูการ์เจลลี่ + 10"){
            countTopping = countTopping + 10;
            toppingIntSelect.add(9);
            toppingInt = 9;
          }else if(widget.chipName == "ว่านหางจรเข้เชื่อม + 15"){
            countTopping = countTopping + 15;
            toppingIntSelect.add(10);
            toppingInt = 10;
          }else if(widget.chipName == "ครีมชีส + 15"){
            countTopping = countTopping + 15;
            toppingIntSelect.add(11);
            toppingInt = 11;
          }else if(widget.chipName == "วิปครีม + 15"){
            countTopping = countTopping + 15;
            toppingIntSelect.add(12);
            toppingInt = 12;
          }
        }) : setState(() {
          toppingSelect.remove(widget.chipName.split(" ")[0]);

          if(widget.chipName == "ไม่ใส่ท็อปปิ้ง + 0") {
            countTopping = 0;
            toppingIntSelect.remove(0);
            toppingInt = 0;
          }else if(widget.chipName == "ไข่มุก + 0"){
            countTopping = 0;
            toppingIntSelect.remove(1);
            toppingInt = 1;
          }else if(widget.chipName == "พุดดิ้ง + 5"){
            countTopping = countTopping - 5;
            toppingInt = 2;
            toppingIntSelect.remove(2);
          }else if(widget.chipName == "เฉาก๊วย + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(3);
            toppingInt = 3;
          }else if(widget.chipName == "วุ้นลิ้นจี่ + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(4);
            toppingInt = 4;
          }else if(widget.chipName == "วุ้นแอปเปิ้ล + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(5);
            toppingInt = 5;
          }else if(widget.chipName == "วุ้นสตรอว์เบอร์รี่ + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(6);
            toppingInt = 6;
          }else if(widget.chipName == "บราวน์ชูการ์ + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(7);
            toppingInt = 7;
          }else if(widget.chipName == "น้ำผึ้ง + 5"){
            countTopping = countTopping - 5;
            toppingIntSelect.remove(8);
            toppingInt = 8;
          }else if(widget.chipName == "บราวน์ชูการ์เจลลี่ + 10"){
            countTopping = countTopping - 10;
            toppingIntSelect.remove(9);
            toppingInt = 9;
          }else if(widget.chipName == "ว่านหางจรเข้เชื่อม + 15"){
            countTopping = countTopping - 15;
            toppingIntSelect.remove(10);
            toppingInt = 10;
          }else if(widget.chipName == "ครีมชีส + 15"){
            countTopping = countTopping - 15;
            toppingIntSelect.remove(11);
            toppingInt = 11;
          }else if(widget.chipName == "วิปครีม + 15"){
            countTopping = countTopping - 15;
            toppingIntSelect.remove(12);
            toppingInt = 12;
          }
        });
        setState(() {
          _isSelected = isSelected;
        });
        print("Topping selected: $toppingSelect");
        print("Topping Int selected: $toppingIntSelect");
        //print("Topping int : $toppingInt");
        print("Topping price : $countTopping");
      },

      selectedColor: const Color.fromRGBO(84, 180, 53, 10),
    );
  }
}

///Size cup
class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;
  const choiceChipWidget(this.reportList, {Key? key}) : super(key: key);

  @override
  State<choiceChipWidget> createState() => _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {

    List<Widget> choices = [];

    for (var item in widget.reportList) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(item),
            labelStyle: const TextStyle(
                color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: const Color(0xffffffff),
            selectedColor: const Color.fromRGBO(84, 180, 53, 10),
            selected: selectedChoice == item,
            onSelected: (isSelected) {
              if(selectedChoice == "Size M") {
                countSize = Get.arguments["price"];
                cupSize = 1;
                sizeCupSelect.add(item);
                print("click size M =  $countSize Bath");
                // print(sizeCupSelect.last);
                print(cupSize);
              }else if(selectedChoice == "Size L") {
                cupSize = 2;
                sizeCupSelect.add(item);
                countSize = Get.arguments["price"]+ 5;
                print("click size L =  $countSize Bath");
                // print(sizeCupSelect.last);
                print(cupSize);
              }
              setState(() {
                selectedChoice = item;
              });
            },
          ),
        )
      );
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

///Sweetness level
class choiceChipWidgetTwo extends StatefulWidget {
  final List<String> reportList;
  const choiceChipWidgetTwo(this.reportList, {Key? key}) : super(key: key);

  @override
  State<choiceChipWidgetTwo> createState() => _choiceChipWidgetTwoState();
}

class _choiceChipWidgetTwoState extends State<choiceChipWidgetTwo> {
  String selectedChoice = "";

  _buildChoiceList() {

    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: const TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: const Color(0xffffffff),
          selectedColor: const Color.fromRGBO(84, 180, 53, 10),
          selected: selectedChoice == item,
          onSelected: (isSelected) {
            sweetnessSelect.add(item);
            if(selectedChoice == "ไม่หวาน") {
                sweetnessInt = 0;
                print("no sugar : $sweetnessInt");
              } else if(selectedChoice == "หวานน้อย") {
                sweetnessInt = 1;
                print("low sugar : $sweetnessInt");
              } else if(selectedChoice == "หวานปานกลาง") {
                sweetnessInt = 2;
                print("sugar ปานกลาง : $sweetnessInt");
              } else if(selectedChoice == "หวานปกติ") {
                sweetnessInt = 3;
                print("sugar ปกติ : $sweetnessInt");
              } else if(selectedChoice == "หวานมาก") {
                sweetnessInt = 4;
                print("sugar หวานมาก : $sweetnessInt");
              }
            // isSelected?
            // setState(() {
            //   sweetnessSelect.add(item);
            //   if(selectedChoice == "ไม่หวาน") {
            //     sweetnessInt = 0;
            //     print("no sugar : $sweetnessInt");
            //   } else if(selectedChoice == "หวานน้อย") {
            //     sweetnessInt = 1;
            //     print("low sugar : $sweetnessInt");
            //   } else if(selectedChoice == "หวานปานกลาง") {
            //     sweetnessInt = 2;
            //     print("sugar ปานกลาง : $sweetnessInt");
            //   } else if(selectedChoice == "หวานปกติ") {
            //     sweetnessInt = 3;
            //     print("sugar ปกติ : $sweetnessInt");
            //   } else if(selectedChoice == "หวานมาก") {
            //     sweetnessInt = 4;
            //     print("sugar หวานมาก : $sweetnessInt");
            //   }
            // }) : setState(() {
            //   sweetnessSelect.remove(item);
            // });
            setState(() {
              selectedChoice = item;
            });
            print(sweetnessSelect.last);
            print(sweetnessInt);
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

///Amount
class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 130.0, bottom: 10),
        child: Row(
            children: <Widget>[
              buildOutlineButton(
                icon: Icons.remove,
                press: () {
                  if (numOfItems > 1) {
                    setState(() {
                      numOfItems--;
                    });
                    setState(() {
                      amountInCart--;
                    });
                    print("amount in cart : $amountInCart");
                  }
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  numOfItems.toString().padLeft(2, "0"),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              buildOutlineButton(
                  icon: Icons.add,
                  press: () {
                    if (numOfItems < 10) {
                      setState(() {
                        numOfItems++;
                      });
                      setState(() {
                        amountInCart++;
                      });
                    }
                    print("amount in cart : $amountInCart");
                  }
              ),
            ])
    );
  }

  SizedBox buildOutlineButton({required IconData icon, required Function() press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shadowColor: const Color.fromARGB(255, 234, 127, 251),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: press,
        child: const Icon(Icons.remove),
      ),
    );
  }
}
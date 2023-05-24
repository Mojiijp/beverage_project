// ignore_for_file: unused_import, camel_case_types

import 'package:beverage_project/page/basket_screen.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/model/topping.dart';
import 'package:beverage_project/src/services/topping_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> toppingSelect = [];
List<String> sizeCupSelect = [];
List<String> sweetnessSelect = [];


int countSize = 0;
int countTopping = 0;
int amountInCart = 1;

class DetailScreen extends StatefulWidget {

  const DetailScreen({super.key});

  // final String id;
  // final String date;
  // final String time;
  //final Menu milktea;

  // DetailScreen(this.id,this.date,this.time,
  //     //this.milktea
  // );

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {



  List topping_list = [];

  void dataStore() async
  {
    setState(() async{
      topping_list = await ToppingService().fetchTopping();}
    );

    print("toppinggggggggggggggggggggg");
  }



  List<String> chipList1 = [
    "Size M",
    "Size L",
  ];

  List<String> chipList2 = [
    "ไม่หวาน",
    "หวานน้อย",
    "หวานปกติ",
    "หวานมาก",
    "หวานสุด ๆ",
  ];
  //

  @override
  void initState() {
    super.initState();
   
    dataStore(); 
    print(topping_list);
    
    print('len => $topping_list.length');
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
                        height: 320,
                        color: Colors.white,
                        child: Column(
                          children: [
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
                            Text(
                              "$countSize บาท * จำนวน $amountInCart แก้ว",
                              style: GoogleFonts.kanit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1C6B00)
                              ),
                            ),
                            Text(
                              "รวมราคาเครื่องดื่ม ${countSize * amountInCart} บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1C6B00)
                              ),
                            ),
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
                          choiceChipWidget(chipList1),
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
                          choiceChipWidgetTwo(chipList2),
                        ],
                      ),
                      const Divider(color: Colors.blueGrey, height: 10.0),
          
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _titleContainer("จำนวน"),
                        ),
                      ),
                      const CartCounter(),
          
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            // shape: Border.all(width: 5),
                            onPressed: () {
                              Get.to(() => BasketScreen(),
                                  arguments: {
                                    "image" : Get.arguments["image"],
                                    "name" : Get.arguments["name"],
                                    "price" : Get.arguments["price"],
                                    "priceCal" : countSize * amountInCart,
                                    "amount" : amountInCart,
                                    "sizeCup" : sizeCupSelect.last,
                                    "sweet" : sweetnessSelect.last
                                  }
                              );
                              print("Size cup : ${sizeCupSelect.last}");
                              print("Sweetness level : ${sweetnessSelect.last}");
                              print(countSize * amountInCart);
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

        // isSelected?
        // setState(() {
        //   toppingSelect.add(widget.chipName.split(" ")[0]);
        // })
        // print("Selected: ${widget.chipName.split(" ")[0]}")
        //     : setState(() {
        //   toppingSelect.remove(widget.chipName.split(" ")[0]);
        // });
        setState(() {
          _isSelected = isSelected;
        });
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
            if(selectedChoice == "Size M") {
              countSize = Get.arguments["price"];
              sizeCupSelect.add(item);
              print("click size M =  $countSize Bath");
              print(sizeCupSelect.last);
            }else if(selectedChoice == "Size L") {
              countSize = Get.arguments["price"]+ 5;
              print("click size L =  $countSize Bath");
            }
            // isSelected?
            // setState(() {
            //   sizecupSelect.add(item);
            // })
            //     : setState(() {
            //   sizecupSelect.remove(item);
            // });
            setState(() {
              selectedChoice = item;
            });
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
            isSelected?
            setState(() {
              sweetnessSelect.add(item);
            })
                : setState(() {
              sweetnessSelect.remove(item);
            });
            setState(() {
              selectedChoice = item;
            });
            print(sweetnessSelect.last);
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
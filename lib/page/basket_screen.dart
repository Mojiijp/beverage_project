import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

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
              height: 510,
              color: Colors.pink,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          width: 100,
                          height: 100,
                          image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(Get.arguments["image"])
                        ),
                        Column(
                          children: [
                            Text(
                              Get.arguments["name"],
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.black
                              ),
                            ),
                            Text(
                              "0 บาท",
                              style: GoogleFonts.kanit(
                                  fontSize: 28,
                                  color: Colors.green
                              ),
                            ),
                          ],
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
                            style: GoogleFonts.mulish(
                                fontSize: 28,
                                color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),

            // Center(
            //   child: Text(
            //     "ยังไม่มีรายการที่เลือกไว้",
            //     style: GoogleFonts.kanit(
            //       fontSize: 22
            //     ),
            //   ),
            // ),

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
                        "0 บาท",
                        style: GoogleFonts.kanit(
                          fontSize: 26,
                          color: Color(0xff1C6B00)
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  ///submit button
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
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

                  ///Add order button
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed:() {},
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

          ],
        )
      ),
    );
  }
}

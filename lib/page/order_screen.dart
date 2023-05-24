import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

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
                      ),
                      Text(
                        "Order",
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

            SizedBox(
              height: 300,
            ),

            Center(
              child: Text(
                "ยังไม่มีรายการสั่งซื้อในตอนนี้",
                style: GoogleFonts.kanit(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

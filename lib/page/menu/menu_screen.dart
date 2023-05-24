import 'package:beverage_project/page/basket_screen.dart';
import 'package:beverage_project/page/menu/detail_screen.dart';
import 'package:beverage_project/page/menu/list_menu.dart';
import 'package:beverage_project/page/order_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/controller/menu_controller.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }
//
// class _MenuScreenState extends State<MenuScreen> {
//
//   bool _isShow = false;
//   bool _isShow2 = false;
//   bool _isShow3 = false;
//
//   @override
//   void initState() {
//     menuController.fetchMenu();
//     super.initState();
//   }
//
//   final menuController = Get.put(MenuController1());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffEDF1D6),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// App bar menu
//             Container(
//               width: 500,
//               height: 60,
//               color: const Color(0xff609966),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                     ),
//                     Text(
//                       "Menu",
//                       style: GoogleFonts.mulish(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white
//                       ),
//                     ),
//                     Container(
//                       width: 50,
//                       height: 50,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                       ),
//                       child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.notifications, size: 35,),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             ///Title
//             Padding(
//               padding: const EdgeInsets.only(left: 8, top: 8),
//               child: Text(
//                 "Our",
//                 style: GoogleFonts.mulish(
//                     fontSize: 28,
//                     color: Colors.black
//                 ),
//               ),
//             ),
//             ///Title 2
//             Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Text(
//                 "Menu",
//                 style: GoogleFonts.mulish(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black
//                 ),
//               ),
//             ),
//
//             ///Grid View
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children : [
//                   ///Fruits tea
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: GestureDetector(
//                       onTap: () {
//                         print("Click");
//                         setState(() {
//                             _isShow = !_isShow;
//                           },
//                         );
//                       },
//                       child: Container(
//                         width: 140,
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20)
//                         ),
//                         child: Column(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.only(top: 3),
//                               child: Image(
//                                 image: AssetImage("assets/apple_tea.png"),
//                               ),
//                             ),
//                             Text(
//                               "ชาผลไม้",
//                               style: GoogleFonts.kanit(
//                                   fontSize: 16,
//                                   //fontWeight: FontWeight.bold,
//                                   color: Colors.black
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ),
//                   ),
//                   ///Milks tea
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: GestureDetector(
//                         onTap: () {
//                           print("Click");
//                           setState(
//                                 () {
//                               _isShow2 = !_isShow2;
//                             },
//                           );
//                         },
//                         child: Container(
//                           width: 140,
//                           height: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Column(
//                             children: [
//                               const Image(
//                                 image: AssetImage("assets/milk_tea.png"),
//                               ),
//                               Text(
//                                 "ชานม",
//                                 style: GoogleFonts.kanit(
//                                     fontSize: 16,
//                                     //fontWeight: FontWeight.bold,
//                                     color: Colors.black
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                     ),
//                   ),
//                   ///Healthy tea
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: GestureDetector(
//                         onTap: () {
//                           print("Click");
//                           setState(
//                                 () {
//                               _isShow3 = !_isShow3;
//                             },
//                           );
//                         },
//                         child: Container(
//                           width: 140,
//                           height: 150,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Column(
//                             children: [
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 8),
//                                 child: Image(
//                                   image: AssetImage("assets/ulong_tea.png"),
//                                 ),
//                               ),
//                               Text(
//                                 "ชาเพื่อสุขภาพ",
//                                 style: GoogleFonts.kanit(
//                                     fontSize: 16,
//                                     //fontWeight: FontWeight.bold,
//                                     color: Colors.black
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                     ),
//                   ),
//                 ]
//               ),
//             ),
//
//             SizedBox(height: 10),
//
//             ///List view
//             GestureDetector(
//               onTap: () {
//                 print('click menu');
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return const DetailScreen();
//                       },
//                     )
//                 );
//               },
//               child: Visibility(
//                 visible: _isShow,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(
//                       color: Colors.transparent, //<-- SEE HERE
//                     ),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: Container(
//                     height: 120,
//                     width: 430,
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         ///Image
//                         Image.asset("assets/apple_tea.png"),
//                         ///Name of tea
//                         Column(
//                           children: [
//                             Text(
//                               'ชาแอปเปิ้ล',
//                               // '${controller.menu[index].name}',
//                               style: GoogleFonts.kanit(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             Text(
//                               'Apple Tea',
//                               style: GoogleFonts.mulish(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(width: 120),
//                         ///price
//                         Container(
//                           width: 50,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: const Color(0xff9DC08B)
//                           ),
//                           child: Center(
//                             child: Text(
//                               '35 ฿',
//                               style: GoogleFonts.kanit(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             ///List view2
//             Visibility(
//               visible: _isShow2,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(
//                     color: Colors.transparent, //<-- SEE HERE
//                   ),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Container(
//                   height: 120,
//                   width: 430,
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       ///Image
//                       Image.asset("assets/milk_tea.png"),
//                       ///Name of tea
//                       Column(
//                         children: [
//                           Text(
//                             'ชานม',
//                             // '${controller.menu[index].name}',
//                             style: GoogleFonts.kanit(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                           Text(
//                             'Milk Tea',
//                             style: GoogleFonts.mulish(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(width: 120),
//                       ///price
//                       Container(
//                         width: 50,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: const Color(0xff9DC08B)
//                         ),
//                         child: Center(
//                           child: Text(
//                             '35 ฿',
//                             style: GoogleFonts.kanit(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             ///List view3
//             Visibility(
//               visible: _isShow3,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   side: const BorderSide(
//                     color: Colors.transparent, //<-- SEE HERE
//                   ),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Container(
//                   height: 120,
//                   width: 430,
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     children: [
//                       ///Image
//                       Image.asset("assets/ulong_tea.png"),
//                       ///Name of tea
//                       Column(
//                         children: [
//                           Text(
//                             'ชาอู่หลง',
//                             // '${controller.menu[index].name}',
//                             style: GoogleFonts.kanit(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                           Text(
//                             'U-Long Tea',
//                             style: GoogleFonts.mulish(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(width: 120),
//                       ///price
//                       Container(
//                         width: 50,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: const Color(0xff9DC08B)
//                         ),
//                         child: Center(
//                           child: Text(
//                             '35 ฿',
//                             style: GoogleFonts.kanit(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       ///Basket
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xff609966),
//         foregroundColor: Colors.black,
//         onPressed: () {
//           Get.toNamed(Routes.basketScreen);
//         },
//         child: const Icon(Icons.shopping_basket),
//       )
//     );
//   }
// }

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

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

            // FutureBuilder<List<Menu>>(
            //   future: menuTea,
            //   builder: (context, snapshot) {
            //     print("builder");
            //     print(snapshot.connectionState);
            //     if (snapshot.hasData) {
            //       return ListView.builder(
            //           itemBuilder: (context, index) {
            //             return Card(
            //               child: ListTile(
            //                 title: Text('${snapshot.data![index].name}'),
            //               ),
            //             );
            //           }
            //       );
            //     } else if (snapshot.hasError) { // กรณี error
            //       return Text('${snapshot.error}');
            //     }
            //     return Text("No Data!!!");
            //     //return const CircularProgressIndicator();
            //   },
            // )
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


// class ListMenu extends StatefulWidget {
//   final String menu;
//   const ListMenu(this.menu);
//
//   @override
//   State<ListMenu> createState() => _ListMenuState();
//
// }
//
// class _ListMenuState extends State<ListMenu> {
//   List menu_list = [];
//
//   dataStore() async{
//     setState(()async{menu_list = await fetchMenu(widget.menu);});
//   }
//
//
//   @override
//   void initState() {
//     print("menu ${widget.menu}");
//     super.initState();
//     fetchMenu(widget.menu).then((value){
//       setState(() {
//         menu_list=value;
//       });
//     });
//     print('len => $menu_list.length');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: menu_list.length,
//         itemBuilder: (context, index) {
//           // ignore: unused_local_variable
//           Menu menuTea = menu_list[index];
//           print("path => ${menuTea.image_path}");
//           return Card(
//             child: ListTile(
//               title: Text("${menuTea.name}"),
//               subtitle: Text(
//                 "฿${menuTea.price}",
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Color.fromARGB(255, 38, 106, 40),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               leading: Image.network('http://192.168.1.4:8000/api/menu/image/${menuTea.image_path}'),
//               trailing: const Icon(Icons.arrow_forward),
//               onTap: () {},
//             ),
//           );
//         }
//     );
//   }
// }

import 'package:beverage_project/page/menu/detail_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:beverage_project/src/model/menu.dart';
import 'package:beverage_project/src/services/menu_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListMenu extends StatefulWidget {
  final int menu;
  const ListMenu(this.menu);

  @override
  State<ListMenu> createState() => _ListMenuState();

}

class _ListMenuState extends State<ListMenu> {
  List menu_list = [];

  dataStore() async{
    setState(()async{menu_list = await MenuService().fetchMenu(widget.menu);});
  }


  @override
  void initState() {
    print("menu ${widget.menu}");
    super.initState();
    MenuService().fetchMenu(widget.menu).then((value){
      setState(() {
        menu_list=value;
      });
    });
    print('len => $menu_list.length');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: menu_list.length,
        itemBuilder: (context, index) {
          // ignore: unused_local_variable
          Menu menuTea = menu_list[index];
          print("path => ${menuTea.image_path}");
          return Card(
            child: ListTile(
              title: Text(
                  "${menuTea.name}",
                style: GoogleFonts.kanit(
                  fontSize: 18
                ),
              ),
              subtitle: Text(
                "฿${menuTea.price}",
                style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Color.fromARGB(255, 38, 106, 40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Image.network('http://192.168.1.10:8000/api/menu/image/${menuTea.id}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Get.toNamed(Routes.detailScreen);
                Get.to(() => DetailScreen(),
                  arguments: {
                    "image" : 'http://192.168.1.10:8000/api/menu/image/${menuTea.id}',
                    "name" : menuTea.name,
                    "price" : menuTea.price
                  }
                );

                print(menuTea.id);
                print(menuTea.name);
                print("price is : ${menuTea.price}");
              },
            ),
          );
        }
    );
  }
}

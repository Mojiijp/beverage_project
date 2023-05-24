import 'package:beverage_project/page/order_screen.dart';
import 'package:beverage_project/page/home_screen.dart';
import 'package:beverage_project/page/menu/menu_screen.dart';
import 'package:beverage_project/page/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    //const HomeScreen(),
    const MenuScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
          print(value);
        },
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xffd3d3d3),
        iconSize: 35,
        fixedColor: const Color(0xff7dce13),
        items: const [
          //BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_drink), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Oder'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

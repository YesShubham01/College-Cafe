import 'package:cafe/pages/MainPage%20Content/favourite_page.dart';
import 'package:cafe/pages/MainPage%20Content/history_page.dart';
import 'package:cafe/pages/MainPage%20Content/ProfilePage%20Widgets/profile_page.dart';
import "package:cafe/theme/color_theme.dart";
import "package:cafe/widgets/drawer_widget.dart";
import "package:flutter/material.dart";

import 'MainPage Content/HomePage Widgets/home_page2.dart';
import 'Order Page/order_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _body_select_element_at(int index) {
    if (index == 0) {
      return const HomePage2();
    } else if (index == 1) {
      return const FavouritePage();
    } else if (index == 2) {
      return const ProfilePage();
    } else if (index == 3) {
      return const HistoryPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: PRIMARY_COLOR,

        // Title
        title: const Text(
          "Cafetaria",
          style: TextStyle(color: Colors.white),
        ),

        // Cart Icon on AppBar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const OrderPage()));
            },
          ),
        ],
      ),

      // Drawer
      drawer: const DrawerWidget(),

      // body
      body: _body_select_element_at(_selectedIndex),

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
              ),
              label: 'History',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: Colors.black45,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}

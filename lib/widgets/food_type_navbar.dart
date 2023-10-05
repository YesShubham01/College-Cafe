import 'package:cafe/pages/Food%20Menu/food_items.dart';
import 'package:flutter/material.dart';

import '../theme/color_theme.dart';

class FoodTypeNavBar extends StatefulWidget {
  const FoodTypeNavBar({super.key});

  @override
  State<FoodTypeNavBar> createState() => _FoodTypeNavBarState();
}

class _FoodTypeNavBarState extends State<FoodTypeNavBar> {
  int _selectedIndex = 0;
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _item_from_index() {
    if (_selectedIndex == 0) {
      return const FoodItemView();
    } else {
      return const FoodItemView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Food',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Snacks',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Drinks',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(),
                label: 'Others',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: PRIMARY_COLOR,
            unselectedItemColor: Colors.black45,
            onTap: _onItemTapped,
            elevation: 1,
          ),
          _item_from_index(),
        ],
      ),
    );
  }
}

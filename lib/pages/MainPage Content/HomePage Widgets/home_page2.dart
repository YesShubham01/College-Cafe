import 'package:cafe/pages/MainPage%20Content/HomePage%20Widgets/food_searchbar.dart';
import 'package:cafe/pages/MainPage%20Content/HomePage%20Widgets/head_text.dart';
import 'package:flutter/material.dart';
import 'package:cafe/Services/FireStore Service/firestore_services.dart';
import '../../../Services/FireStore Service/single_item_data.dart';
import '../../../theme/color_theme.dart';
import '../../../widgets/two_food_items_widget.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int _food_type_index = 0;
  final String _test = '';
  _onItemTapped(int index) {
    setState(() {
      _food_type_index = index;
    });
  }

  _get_fetched_fooditems() {
    if (_food_type_index == 0) {
      SingleItemData i =
          SingleItemData(name: "Name", price: 00, image: "Image", id: -1);
      return TwoItems(
        item_1: i,
        item_2: i,
      );
    }
  }

  int _fetched_itemcount = 1;

  // use Future Builder
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SingleItemData>>(
      future: FireStore().get_available_food_items(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SingleItemData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const DeliciousFoodText();
                }
                if (index == 1) {
                  return const SearchBarOfFood();
                }
                if (index == 2) {
                  return BottomNavigationBar(
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
                    currentIndex: _food_type_index,
                    selectedItemColor: PRIMARY_COLOR,
                    unselectedItemColor: Colors.black45,
                    onTap: _onItemTapped,
                    elevation: 1,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              });
        } else if (snapshot.hasError) {
          return Container(
            height: 350,
            color: Colors.red,
          );
        } else if (snapshot.hasData) {
          List<SingleItemData>? listOfFood = snapshot.data;
          if (snapshot.data == null) {
            return Container(
              height: 350,
              color: Colors.red,
              child: const Center(
                child: Text("null"),
              ),
            );
          } else {
            _fetched_itemcount = listOfFood!.length;
            // _test = listOfFood[0].name;
          }
          int counter = 0;
          double halfOfFetchedItems = listOfFood.length / 2;
          return ListView.builder(
              itemCount: listOfFood.length + 3,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const DeliciousFoodText();
                }
                if (index == 1) {
                  return const SearchBarOfFood();
                }
                if (index == 2) {
                  return BottomNavigationBar(
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
                    currentIndex: _food_type_index,
                    selectedItemColor: PRIMARY_COLOR,
                    unselectedItemColor: Colors.black45,
                    onTap: _onItemTapped,
                    elevation: 1,
                  );
                } else if (index < (_fetched_itemcount / 2) + 3) {
                  for (var k in listOfFood) {
                    print(k.name);
                  }
                  SingleItemData i = listOfFood[counter];
                  SingleItemData i2;
                  try {
                    i2 = listOfFood[counter + 1];
                  } catch (e) {
                    i2 = SingleItemData(
                        name: "Name", price: 00, image: "Image", id: -1);
                  }

                  counter += 2;
                  print("$_fetched_itemcount \n\n");
                  return TwoItems(
                    item_1: i,
                    item_2: i2,
                  );
                } else {
                  print("null");
                  return Container();
                }
              });
        } else {
          return Container(
            height: 350,
            color: Colors.pink,
          );
        }
      },
    );
  }
}

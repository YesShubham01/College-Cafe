import 'package:flutter/material.dart';

import '../../../Services/FireStore Service/firestore_services.dart';
import '../../../Services/FireStore Service/single_item_data.dart';
import '../../../theme/color_theme.dart';
import '../../../widgets/two_food_items_widget.dart';
import 'food_searchbar.dart';
import 'head_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _food_type_index = 0;
  final String _test = '';
  _onItemTapped(int index) {
    setState(() {
      _food_type_index = index;
    });
  }

  _get_fetched_fooditems() {
    if (_food_type_index == 0) {
      SingleItemData i = SingleItemData(
          name: ":)",
          price: 00,
          image:
              "https://firebasestorage.googleapis.com/v0/b/cafe-backend-dfb00.appspot.com/o/icon.png?alt=media&token=1e1b0cdb-193d-42f8-987f-45bad70d4f0d&_gl=1*vmj21e*_ga*ODQyMjk1MTU3LjE2NzkyMjQxNDQ.*_ga_CW55HF8NVT*MTY5NjY4OTc5My4zMC4xLjE2OTY2OTMxNTQuNDkuMC4w",
          id: -1);
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
    return FutureBuilder<List<List<SingleItemData>>>(
      future: FireStore().get_available_all_items(),
      builder: (BuildContext context,
          AsyncSnapshot<List<List<SingleItemData>>> snapshot) {
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
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              });
        } else if (snapshot.hasError) {
          return Container(
            height: 350,
            color: Colors.red,
          );
        } else if (snapshot.hasData) {
          List<SingleItemData>? listOfFood = snapshot.data![_food_type_index];

          if (snapshot.data == null) {
            return Container(
              height: 350,
              color: Colors.red,
              child: const Center(
                child: Text("null"),
              ),
            );
          } else {
            _fetched_itemcount = listOfFood.length;
            // _test = listOfFood[0].name;
          }
          int counter = 0;
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
                  SingleItemData i = listOfFood[counter];
                  SingleItemData i2;
                  try {
                    i2 = listOfFood[counter + 1];
                  } catch (e) {
                    i2 = SingleItemData(
                        name: ":)",
                        price: 00,
                        image:
                            "https://firebasestorage.googleapis.com/v0/b/cafe-backend-dfb00.appspot.com/o/icon.png?alt=media&token=1e1b0cdb-193d-42f8-987f-45bad70d4f0d&_gl=1*vmj21e*_ga*ODQyMjk1MTU3LjE2NzkyMjQxNDQ.*_ga_CW55HF8NVT*MTY5NjY4OTc5My4zMC4xLjE2OTY2OTMxNTQuNDkuMC4w",
                        id: -1);
                  }

                  counter += 2;
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

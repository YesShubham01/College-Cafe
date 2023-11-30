import 'package:cafe/Services/FireStore%20Service/firestore_services.dart';
import 'package:cafe/pages/Item%20Page/item_page.dart';
import 'package:flutter/material.dart';

import '../../Services/FireStore Service/single_item_data.dart';
import '../../theme/color_theme.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<SingleItemData> items = [
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SingleItemData>>(
      future: FireStore().getFavItems(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SingleItemData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            items = snapshot.data!;
          }

          if (items.isEmpty) {
            return const Center(
              child: Text(
                "Oops! Favourite list is empty.",
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Swipe items to remove from Favourites',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 170, 23, 13)
                              .withOpacity(.9),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        itemBuilder: (BuildContext context, index) {
                          return Dismissible(
                            key: const Key('item '),
                            onDismissed: (DismissDirection direction) {
                              if (direction == DismissDirection.startToEnd) {
                                print("Add to favorite");
                              } else {
                                print('Remove item');
                              }
                              FireStore().removeFromFav(items[index].id!);
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemPage(data: items[index]),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                foregroundImage:
                                    NetworkImage(items[index].image),
                                radius: 35,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                              title: Text(
                                items[index].name,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6),
                                    fontSize: 18),
                              ),
                              subtitle: Text(
                                'Rs. ${items[index].price.toString()}',
                                style: TextStyle(
                                    color: Colors.red.withOpacity(.6)),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}

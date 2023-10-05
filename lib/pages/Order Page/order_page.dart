import 'package:cafe/Services/FireStore%20Service/firestore_services.dart';
import 'package:cafe/Services/FireStore%20Service/single_item_data.dart';
import 'package:cafe/pages/Order%20Page/loading_orderpage.dart';
import 'package:flutter/material.dart';

import '../../theme/color_theme.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<SingleItemData> items = [
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
    SingleItemData(
        name: "Name", price: 100, image: "images/ymca_logo.png", id: 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.fromLTRB(90, 10, 0, 0), child: Text("Cart")),
      ),
      body: FutureBuilder<List<SingleItemData>>(
        future: FireStore().getCartItems(),
        builder: ((BuildContext context,
            AsyncSnapshot<List<SingleItemData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingOrderPage();
          } else if (snapshot.hasError) {
            // If there's an error, display an error message
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasData) {
              items = snapshot.data!;
            } else {
              print("data not found");
            }
            if (items.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Text("Oops!, Cart is empty.",
                          style: TextStyle(fontSize: 20)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: SizedBox(
                        height: 70,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PRIMARY_COLOR,
                          ),
                          child: const Text(
                            'Complete Order',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: [
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
                            FireStore().removeFromCart(items[index].id!);
                            setState(() {
                              items.removeAt(index);
                            });
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              foregroundImage: NetworkImage(items[index].image),
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
                              style:
                                  TextStyle(color: Colors.red.withOpacity(.6)),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 50),
                  child: SizedBox(
                    height: 70,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text(
                        'Complete Order',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

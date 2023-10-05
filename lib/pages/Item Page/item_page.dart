import 'package:cafe/Services/FireStore%20Service/firestore_services.dart';
import 'package:cafe/Services/FireStore%20Service/single_item_data.dart';
import 'package:cafe/pages/Order%20Page/order_page.dart';
import 'package:flutter/material.dart';

import '../../theme/color_theme.dart';

class ItemPage extends StatefulWidget {
  final SingleItemData data;
  const ItemPage({super.key, required this.data});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  void _onClick_addToCart() {
    if (widget.data.id == null) {
      print("ID doesn't exist.");
      return;
    }
    FireStore().addToCart(widget.data.id!);
    print("item added to cart.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
            child: Center(
              child: SizedBox(
                height: 250,
                width: 250,
                child: CircleAvatar(
                  foregroundImage: NetworkImage(widget.data.image),
                  radius: 65,
                  backgroundColor: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.data.name,
            style: const TextStyle(fontSize: 30),
          ),
          Text(
            'Rs. ${widget.data.price.toString()}',
            style: const TextStyle(fontSize: 22, color: Colors.orange),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
            child: SizedBox(
              height: 70,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _onClick_addToCart();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const OrderPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

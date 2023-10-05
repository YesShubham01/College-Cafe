import 'package:flutter/material.dart';

import '../Services/FireStore Service/single_item_data.dart';
import 'food_item_widget.dart';

class TwoItems extends StatefulWidget {
  final SingleItemData item_1;
  final SingleItemData item_2;

  const TwoItems({super.key, required this.item_1, required this.item_2});

  @override
  State<TwoItems> createState() => _TwoItemsState();
}

class _TwoItemsState extends State<TwoItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FoodItem(
          data: widget.item_1,
        ),
        FoodItem(
          data: widget.item_2,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class FoodItemView extends StatefulWidget {
  const FoodItemView({super.key});

  @override
  State<FoodItemView> createState() => _FoodItemViewState();
}

class _FoodItemViewState extends State<FoodItemView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return const TwoItems();
          }),
    );
  }
}

class TwoItems extends StatefulWidget {
  const TwoItems({super.key});

  @override
  State<TwoItems> createState() => _TwoItemsState();
}

class _TwoItemsState extends State<TwoItems> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // FoodItem(),
        // FoodItem(),
      ],
    );
  }
}

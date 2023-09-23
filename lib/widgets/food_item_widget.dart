import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  const FoodItem({super.key});

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 100, 10, 50),
            child: SizedBox(
              height: 280,
              width: 150,
              child: Card(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                    child: Column(
                      children: [Text("Item Name"), Text("Price")],
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(21, 70, 20, 50),
            child: CircleAvatar(
              radius: 65,
              backgroundColor: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }
}

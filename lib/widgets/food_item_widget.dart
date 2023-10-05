import 'package:cafe/Services/FireStore%20Service/single_item_data.dart';
import 'package:cafe/pages/Item%20Page/item_page.dart';
import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final SingleItemData data;
  const FoodItem({super.key, required this.data});

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ItemPage(
                  data: widget.data,
                )));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 70, 10, 50),
            child: SizedBox(
              height: 220,
              width: 160,
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: Column(
                      children: [
                        Text(widget.data.name),
                        Text('Rs. ${widget.data.price.toString()}')
                      ],
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 20, 50),
            child: CircleAvatar(
              foregroundImage: NetworkImage(widget.data.image),
              radius: 65,
              backgroundColor: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }
}

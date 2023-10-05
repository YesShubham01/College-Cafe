import 'package:cafe/widgets/food_type_navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          child: Text("Delicious\nfood for you",
              style: TextStyle(
                fontSize: 34,
              )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SearchBar(
            backgroundColor: MaterialStatePropertyAll(Colors.white),
            elevation: MaterialStatePropertyAll(1),
            hintText: " Search",
          ),
        ),
        FoodTypeNavBar(),
      ]),
    );
  }
}

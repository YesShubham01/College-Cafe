import 'package:flutter/material.dart';

class SearchBarOfFood extends StatelessWidget {
  const SearchBarOfFood({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
      child: SearchBar(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        elevation: MaterialStatePropertyAll(1),
        hintText: " Search",
      ),
    );
  }
}

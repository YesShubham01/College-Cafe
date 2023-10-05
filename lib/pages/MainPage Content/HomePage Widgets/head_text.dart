import "package:flutter/material.dart";

class DeliciousFoodText extends StatelessWidget {
  const DeliciousFoodText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      child: Text("Delicious\nfood for you",
          style: TextStyle(
            fontSize: 34,
          )),
    );
  }
}

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          "My Profile",
          style: TextStyle(fontSize: 35),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(40, 30, 40, 5),
        child: Row(
          children: [Text("Personal Details"), Spacer(), Text("change")],
        ),
      ),
      SizedBox(
        height: 200,
        width: 300,
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset("images/ymca_logo.png"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 20, 0),
                child: Column(
                  children: [
                    Text("Name", textAlign: TextAlign.left),
                    Text("     Phone no.", textAlign: TextAlign.left),
                    Text("      Other Detail", textAlign: TextAlign.left),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

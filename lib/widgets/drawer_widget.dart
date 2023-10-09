import 'package:cafe/Services/FireAuth%20Service/authentication.dart';
import 'package:cafe/pages/SplashPage/splash_page.dart';
import 'package:cafe/res/strings.dart';
import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,
            ),
            child: Text(
              APP_TITLE,
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          ListTile(
            iconColor: Colors.red,
            textColor: Colors.red,
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Authenticate.sign_out();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Signed Out!'),
                  duration:
                      Duration(seconds: 3), // Adjust the duration as needed
                ),
              );
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SplashPage()));
            },
          ),
        ],
      ),
    );
  }
}

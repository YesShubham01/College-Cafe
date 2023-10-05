import 'package:cafe/Services/FireAuth%20Service/authentication.dart';
import 'package:cafe/pages/Login%20Page/login_page.dart';
import 'package:flutter/material.dart';

import '../main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _checkAuthenticationAndNavigate() async {
    if (Authenticate.isLoggedIn()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to schedule navigation after build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthenticationAndNavigate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orange,
    );
  }
}

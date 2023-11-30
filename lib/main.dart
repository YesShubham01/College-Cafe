import 'package:cafe/pages/SplashPage/splash_page.dart';
import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51NxrFZSByBFnaKsK4iouTi944Hi7B96BHaXdJr5JCVQfoTnMKY8zYIDwcrxFSnfV20IzfwKGjYluCl9LWmYcPXnK0035eQONdX';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College-Cafe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY_COLOR),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

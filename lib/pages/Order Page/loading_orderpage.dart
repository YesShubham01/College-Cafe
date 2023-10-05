import 'package:flutter/material.dart';

import '../../theme/color_theme.dart';

class LoadingOrderPage extends StatefulWidget {
  const LoadingOrderPage({super.key});

  @override
  State<LoadingOrderPage> createState() => _LoadingOrderPageState();
}

class _LoadingOrderPageState extends State<LoadingOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 70),
          child: Center(child: CircularProgressIndicator()),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SizedBox(
            height: 70,
            width: 300,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
              ),
              child: const Text(
                'Complete Order',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

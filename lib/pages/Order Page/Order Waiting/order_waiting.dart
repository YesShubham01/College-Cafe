import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({super.key});

  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}

class _OrderWaitingState extends State<OrderWaiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Order Confirmation'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 238, 238, 238),
        child: Column(
          children: [
            const Text(
              "Thank You,",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text(
              "We are Preparing Your Order.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Card(
                color: PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 120,
                  child: Text(
                    "106",
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Items: List of items here:\nItem 1 x1\nItem2 x2',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            const Column(
              children: [
                Text(
                  'Order Number: 106',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Expected Time: 1 minute',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Transaction ID: 0000001',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

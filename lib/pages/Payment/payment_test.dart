import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentTest extends StatefulWidget {
  const PaymentTest({super.key});

  @override
  State<PaymentTest> createState() => _PaymentTestState();
}

class _PaymentTestState extends State<PaymentTest> {
  Map<String, dynamic>? paymentIntentData;

  createPaymentIntent(String amount) async {
    String currency = 'INR';
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51NxrFZSByBFnaKsKhj9ar6x4CttrLk358rm5ijVUTyYRSidsxC2uixWufrJrQP1d0mYywQIUT2jBTUmevRLVlIVv00udh6TjH0',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return jsonDecode(response.body.toString());
    } catch (e) {
      print('exception: $e');
    }
  }

  Future<void> makePayment() async {
    print('clicked');
    try {
      paymentIntentData = await createPaymentIntent('1000');

      print('intent data created');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData?['client-secret'],
          merchantDisplayName: 'Shubham Puhal',
        ),
      );
      print('payment initialised');
      displayPaymentSheet();
      print('display');
    } catch (e) {
      print('exception: $e');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Payment Successful')));
    } catch (e) {
      print('exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: makePayment,
          child: const Text("Make Payment"),
        ),
      ),
    );
  }
}

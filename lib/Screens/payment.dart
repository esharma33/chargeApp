import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'charge_duration.dart';

class Mypayment extends StatefulWidget {
  int amount = 0;
   Mypayment({Key? key, required this.amount}) : super(key: key);

  @override
  State<Mypayment> createState() => _MypaymentState();
}

class _MypaymentState extends State<Mypayment> {
  late Razorpay razorpay;

  void openCheckout() {
    var options = {
      'key': 'rzp_test_M9Z2dqY0Xc5VO6',
      'amount': widget.amount,
      'name': 'PowerStrip',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId!);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Charge_duration_screen()));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName!);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              primary: Colors.blue,
              padding:
              EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              // minimumSize: Size(50,20 ),
            ),
            child: Text(
              "Pay Now", style: TextStyle(fontSize: 16, color: Colors.white),),
            onPressed: openCheckout,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RazarPay extends StatefulWidget {
  const RazarPay({Key? key}) : super(key: key);

  @override
  State<RazarPay> createState() => _RazarPayState();
}

class _RazarPayState extends State<RazarPay> {
  Razorpay? _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print('Payment Success: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print('Payment Error: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print('External Wallet: ${response.walletName}');
  }

  void _openCheckout() {
    var options = {
      'key': 'YOUR_RAZORPAY_API_KEY',
      'amount': 10000, // amount in paise (e.g., 100 for ₹1)
      'name': 'Example App',
      'image' : "assets/splash/splashimages.png",
      'description': 'Test payment',
      'prefill': {'contact': '1234567890', 'email': 'example@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Make Payment'),
          onPressed: _openCheckout,
        ),
      ),
    );
  }
}

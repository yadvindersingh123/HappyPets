import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentScreen extends StatefulWidget {
  final double amount;

  const PaymentScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    try {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    } catch (e) {
      debugPrint('Error initializing Razorpay: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    try {
      Fluttertoast.showToast(
        msg: "Payment Successful: ${response.paymentId}",
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      debugPrint('Error in success handler: $e');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      Fluttertoast.showToast(
        msg: "Payment Failed: ${response.message ?? 'Error occurred'}",
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      debugPrint('Error in error handler: $e');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    try {
      Fluttertoast.showToast(
        msg: "External Wallet Selected: ${response.walletName ?? 'Unknown wallet'}",
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      debugPrint('Error in wallet handler: $e');
    }
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',  // Replace with actual test key
      'amount': widget.amount * 100,
      'name': 'Happy Pets',
      'description': 'Pet Store Purchase',
      'prefill': {
        'contact': '9876543210',
        'email': 'user@example.com'
      },
      'external': {
        'wallets': ['paytm']
      },
      'theme': {
        'color': '#0000FF'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void dispose() {
    try {
      _razorpay.clear();
    } catch (e) {
      debugPrint('Error in dispose: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Payment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue.shade50,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Center vertically
          children: [
            Center(  // Center horizontally
              child: Text(
                'Total Amount: ₹${widget.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(  // Center horizontally
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: openCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
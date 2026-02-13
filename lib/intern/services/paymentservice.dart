import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  static final Razorpay _razorpay = Razorpay();

  static void _clearAllListeners() {
    _razorpay.clear();
  }

  static Future<void> startPayment({
    required double amount,
    required String name,
    required String email,
    required String contact,
    required Function(String) onSuccess,
    required Function(String) onError,
  }) async {
    _clearAllListeners();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      onSuccess(response.paymentId ?? '');
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      onError(response.message ?? 'Payment Error');
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
      debugPrint('External wallet used: ${response.walletName}');
    });

    var options = {
      'key': 'rzp_test_EH1UEwLILEPXCj', // Replace with your test/live key
      'amount': (amount * 100).toInt(),
      'currency': 'INR',
      'name': name,
      'description': 'Course Enrollment Payment',
      'prefill': {'contact': contact, 'email': email},
      'theme': {'color': '#0077B6'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error in Razorpay: $e');
      onError(e.toString());
    }
  }

  static void clear() {
    _clearAllListeners();
  }
}
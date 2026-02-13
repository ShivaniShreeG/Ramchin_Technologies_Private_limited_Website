@JS()
library;

import 'package:js/js.dart';

@JS('Razorpay')
class Razorpay {
  external Razorpay(RazorpayOptions options);
  external void open();
  external void on(String event, Function handler);
}

@JS()
@anonymous
class RazorpayOptions {
  external String get key;
  external int get amount;
  external String get currency;
  external String get name;
  external String get description;
  external String? get image;
  external Prefill get prefill;

  external factory RazorpayOptions({
    String key,
    int amount,
    String currency,
    String name,
    String description,
    String? image,
    Prefill prefill,
  });
}

@JS()
@anonymous
class Prefill {
  external String get name;
  external String get email;
  external String get contact;

  external factory Prefill({
    String name,
    String email,
    String contact,
  });
}

/// SUCCESS RESPONSE MODEL
@JS()
@anonymous
class RazorpaySuccessResponse {
  external String get razorpay_payment_id;
  external String get razorpay_order_id;
  external String get razorpay_signature;
}

/// FAILED RESPONSE MODEL
@JS()
@anonymous
class RazorpayError {
  external String get code;
  external String get description;
  external String get source;
  external String get step;
  external String get reason;
}

@JS()
@anonymous
class RazorpayFailedResponse {
  external RazorpayError get error;
}

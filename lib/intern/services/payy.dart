import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Replace this with your working base URL
const String baseUrl = "https://rks2ql97-3010.inc1.devtunnels.ms";

class RegisterPage extends StatefulWidget {
  final String courseName;
  final String amount;

  const RegisterPage({
    Key? key,
    required this.courseName,
    required this.amount,
  }) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();

  bool isProcessing = false;
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    razorpay.clear();
    super.dispose();
  }

  Future<void> startPayment() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final mobile = contactController.text.trim();

    if (name.isEmpty || email.isEmpty || mobile.isEmpty) {
      showDialogBox("Missing Fields", "Please fill all the fields.");
      return;
    }

    if (!RegExp(r'^[\w\.\+\-]+@[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email)) {
      showDialogBox("Invalid Email", "Please enter a valid email.");
      return;
    }

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(mobile)) {
      showDialogBox("Invalid Mobile", "Enter a valid 10-digit mobile number.");
      return;
    }

    var options = {
      'key': 'rzp_live_RTDsYRSviCdE7N', // use your correct test or live Razorpay key
      'amount': int.parse(widget.amount) * 100, // in paise
      'currency': 'INR',
      'name': 'Ramchin Technologies',
      'description': '${widget.courseName} Course/Internship',
      'prefill': {
        'name': name,
        'email': email,
        'contact': mobile,
      },
      'theme': {'color': '#0077B6'}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      showDialogBox("Error", e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await submitToServer("paid");
    showDialogBox("Payment Successful",
        "Payment ID: ${response.paymentId}", navigate: true);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    await submitToServer("notpaid");
    showDialogBox("Payment Failed",
        response.message ?? "Unknown Error. Please try again.");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showDialogBox("External Wallet", response.walletName ?? "Wallet Used");
  }

  Future<bool> submitToServer(String status) async {
    setState(() {
      isProcessing = true;
    });

    final url = Uri.parse('${baseUrl}register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'mobile': contactController.text.trim(),
          'courseName': widget.courseName,
          'amount': widget.amount,
          'payments_status': status,
        }),
      );

      final data = jsonDecode(response.body);
      setState(() {
        isProcessing = false;
      });

      if (!(data['success'] ?? false)) {
        showDialogBox("Server Error", data['message'] ?? "Unknown error");
        return false;
      }
      return true;
    } catch (e) {
      setState(() {
        isProcessing = false;
      });
      showDialogBox("Error", "Something went wrong. Please try again.");
      return false;
    }
  }

  void showDialogBox(String title, String message, {bool navigate = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (navigate && title == "Payment Successful") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CourseAndInternshipPage()),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget inputField(
      String label, IconData icon, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Register & Pay"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              "Enroll for ${widget.courseName}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            inputField("Full Name", Icons.person, nameController),
            const SizedBox(height: 16),
            inputField("Email", Icons.email, emailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            inputField("Mobile", Icons.phone, contactController,
                keyboardType: TextInputType.phone),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isProcessing ? null : startPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
              ),
              child: isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text("Pay ₹${widget.amount}",
                  style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy secondary page
class CourseAndInternshipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses & Internships")),
      body: const Center(
          child: Text("Welcome to the Courses & Internship Page!")),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:razorpay_web/razorpay_web.dart';
import 'package:intl/intl.dart';
import '../pages/homepage.dart';
import '../services/apiservice.dart';

class CourseApplyPage extends StatefulWidget {
  final String name;
  final int amount;

  const CourseApplyPage({
    Key? key,
    required this.name,
    required this.amount,
  }) : super(key: key);

  @override
  State<CourseApplyPage> createState() => _CourseApplyPageState();
}

class _CourseApplyPageState extends State<CourseApplyPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _college = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _selectedDegree;
  String? _selectedYear;     // "1st year", "2nd year", "Graduate", or "Graduate(2023)"
  String? _selectedSubject;
  String? _graduateYear;     // "2023"

  late Razorpay razorpay;

  List<String> get _subjectOptions {
    switch (_selectedDegree) {
      case "B.Sc":
      case "M.Sc":
        return ["Computer Science", "Data Science", "Maths"];
      case "BCA":
      case "MCA":
        return ["-"];
      case "B.E":
      case "M.E":
        return [
          "Artificial Intelligence & Data Science",
          "Artificial Intelligence & Machine Learning",
          "Artificial Intelligence(AI)",
          "Cloud Computing",
          "Computer Science Engineering(CSE)",
          "Cyber Security",
          "Data Science and Big Analytics",
          "Electronics & Telecommunications",
          "Electronics and Communication Engineering(ECE)",
          "Information Technology (IT)",
          "Internet of Things (IoT)",
          "Robotics and Automation"
        ];
      case "B.Tech":
      case "M.Tech":
        return [
          "Artificial Intelligence & Machine Learning",
          "Cloud Computing",
          "Computer Science Engineering(CSE)",
          "Cyber Security",
          "Data Science",
          "Electronics and Communication Engineering(ECE)",
          "Information Technology(IT)",
          "Internet of Things (IoT)",
          "Robotics and Automation",
        ];
      default:
        return [];
    }
  }

  @override
  void initState() {
    super.initState();

    _selectedDegree = null;
    _selectedYear = null;
    _selectedSubject = null;
    _graduateYear = null;

    razorpay = Razorpay();

    razorpay.on("payment.success", (PaymentSuccessResponse response) async {
      await _handlePaymentSuccess(response.paymentId ?? "");
    });

    razorpay.on("payment.error", (PaymentFailureResponse response) async {
      await _handlePaymentError(response.message ?? "Payment Failed!");
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _college.dispose();
    razorpay.clear();
    super.dispose();
  }

  void _onNameChanged(String value) {
    final capitalized = value.toUpperCase();
    if (_name.text != capitalized) {
      _name.value = TextEditingValue(
        text: capitalized,
        selection: TextSelection.collapsed(offset: capitalized.length),
      );
    }
  }

  void _onCollegeChanged(String value) {
    final capitalized = value.toUpperCase();
    if (_college.text != capitalized) {
      _college.value = TextEditingValue(
        text: capitalized,
        selection: TextSelection.collapsed(offset: capitalized.length),
      );
    }
  }

  // Small year picker – returns only a year like 2023
  Future<void> _showYearPicker() async {
    final now = DateTime.now();
    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(32),
          child: Container(
            width: 280,
            height: 300,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Graduation Year",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20, // last 20 years
                    itemBuilder: (context, index) {
                      final year = now.year - index;
                      return ListTile(
                        dense: true,
                        title: Text(
                          year.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () => Navigator.of(context).pop(year),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _graduateYear = result.toString();
        _selectedYear = "Graduate($_graduateYear)"; // Capital G
      });
    }
  }

  void _show(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (title == "Payment Successful") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const InternshipPage()),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String _yearForApi() {
    // Directly store what dropdown shows
    return _selectedYear ?? "";
  }

  Future _handlePaymentSuccess(String paymentId) async {
    await ApiService.createApplication(
      coursename: widget.name,
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      createdtime: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
      amount: widget.amount.toString(),
      payment_status: "paid",
      transaction_id: paymentId,
      degree: _selectedDegree ?? "",
      subject: _selectedSubject ?? "",
      collegeName: _college.text.trim(),
      yearOfStudy: _yearForApi(),
    );
    _show("Payment Successful", "Payment ID: $paymentId");
  }

  Future _handlePaymentError(String message) async {
    await ApiService.createApplication(
      coursename: widget.name,
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim(),
      createdtime: DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now()),
      amount: widget.amount.toString(),
      payment_status: "not_paid",
      transaction_id: "",
      degree: _selectedDegree ?? "",
      subject: _selectedSubject ?? "",
      collegeName: _college.text.trim(),
      yearOfStudy: _yearForApi(),
    );
    _show("Payment Failed", message);
  }

  void _startPayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    int amount = widget.amount * 100;
    var options = {
      "key": "rzp_test_EH1UEwLILEPXCj",
      "amount": amount,
      "currency": "INR",
      "name": "Ramchin Technologies",
      "description": "${widget.name} - Course & Internship",
      "prefill": {
        "name": _name.text.trim(),
        "email": _email.text.trim(),
        "contact": _phone.text.trim(),
      }
    };

    razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.name.toString();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Apply — $title",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 80,
                              child: Image.asset(
                                'ramchinlogob.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Full Name
                        SizedBox(
                          width: 550,
                          child: TextFormField(
                            controller: _name,
                            style: const TextStyle(fontSize: 18),
                            textCapitalization: TextCapitalization.characters,
                            onChanged: _onNameChanged,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            validator: (v) =>
                            v == null || v.isEmpty ? "Enter your name" : null,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Phone (second)
                        SizedBox(
                          width: 550,
                          child: TextFormField(
                            controller: _phone,
                            style: const TextStyle(fontSize: 18),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: "Phone",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? "Enter your phone number"
                                : null,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Email
                        SizedBox(
                          width: 550,
                          child: TextFormField(
                            controller: _email,
                            style: const TextStyle(fontSize: 18),
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            validator: (v) =>
                            v == null || v.isEmpty ? "Enter your email" : null,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Degree
                        SizedBox(
                          width: 550,
                          child: DropdownButtonFormField<String>(
                            value: _selectedDegree,
                            decoration: const InputDecoration(
                              labelText: "Degree",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(value: "B.Sc", child: Text("B.Sc")),
                              DropdownMenuItem(value: "M.Sc", child: Text("M.Sc")),
                              DropdownMenuItem(value: "BCA", child: Text("BCA")),
                              DropdownMenuItem(value: "MCA", child: Text("MCA")),
                              DropdownMenuItem(value: "B.E", child: Text("B.E")),
                              DropdownMenuItem(value: "M.E", child: Text("M.E")),
                              DropdownMenuItem(value: "B.Tech", child: Text("B.Tech")),
                              DropdownMenuItem(value: "M.Tech", child: Text("M.Tech")),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedDegree = value;
                                _selectedYear = null;
                                _selectedSubject = null;
                                _graduateYear = null;

                                if (value == "BCA" || value == "MCA") {
                                  _selectedSubject = "-";
                                }
                              });
                            },
                            validator: (v) =>
                            v == null || v.isEmpty ? "Select your degree" : null,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Subject
                        SizedBox(
                          width: 550,
                          child: DropdownButtonFormField<String>(
                            value: _selectedSubject,
                            decoration: const InputDecoration(
                              labelText: "Subject",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            items: _subjectOptions
                                .map(
                                  (s) => DropdownMenuItem<String>(
                                value: s,
                                child: Text(s),
                              ),
                            )
                                .toList(),
                            onChanged: (value) {
                              if (_selectedDegree == "BCA" ||
                                  _selectedDegree == "MCA") {
                                return;
                              }
                              setState(() {
                                _selectedSubject = value;
                              });
                            },
                            validator: (v) {
                              if (_selectedDegree == null) {
                                return "Select your degree first";
                              }
                              if (_subjectOptions.isEmpty) {
                                return "No subjects available";
                              }
                              return v == null || v.isEmpty
                                  ? "Select your subject"
                                  : null;
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // College
                        SizedBox(
                          width: 550,
                          child: TextFormField(
                            controller: _college,
                            style: const TextStyle(fontSize: 18),
                            textCapitalization: TextCapitalization.characters,
                            onChanged: _onCollegeChanged,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: "College Name",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? "Enter your college name"
                                : null,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Year of studying
                        SizedBox(
                          width: 550,
                          child: DropdownButtonFormField<String>(
                            value: _selectedYear,
                            decoration: const InputDecoration(
                              labelText: "Year of Studying",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 16,
                              ),
                            ),
                            items: () {
                              if (_selectedDegree == null) {
                                return <DropdownMenuItem<String>>[];
                              }

                              List<String> years;
                              if (_selectedDegree == "M.E" ||
                                  _selectedDegree == "M.Tech") {
                                years = ["1st year", "2nd year"];
                              } else if (_selectedDegree == "B.E" ||
                                  _selectedDegree == "B.Tech") {
                                years = [
                                  "1st year",
                                  "2nd year",
                                  "3rd year",
                                  "4th year"
                                ];
                              } else if (_selectedDegree == "M.Sc" ||
                                  _selectedDegree == "MCA") {
                                years = ["1st year", "2nd year"];
                              } else {
                                years = ["1st year", "2nd year", "3rd year"];
                              }

                              years.add("Graduate");

                              // If already picked Graduate(YYYY), ensure it exists in items
                              if (_selectedYear != null &&
                                  _selectedYear!.startsWith("Graduate(") &&
                                  !years.contains(_selectedYear)) {
                                years.add(_selectedYear!);
                              }

                              return years
                                  .map(
                                    (y) => DropdownMenuItem<String>(
                                  value: y,
                                  child: Text(y),
                                ),
                              )
                                  .toList();
                            }(),
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value;
                                if (value == "Graduate") {
                                  _showYearPicker();
                                } else if (value != null &&
                                    value.startsWith("Graduate(")) {
                                  // keep Graduate(YYYY)
                                } else {
                                  _graduateYear = null;
                                }
                              });
                            },
                            validator: (v) {
                              if (_selectedDegree == null) {
                                return "Select your degree first";
                              }
                              return v == null || v.isEmpty
                                  ? "Select your year"
                                  : null;
                            },
                          ),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          height: 40,
                          width: 160,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: _startPayment,
                            child: Text(
                              "Pay ₹${widget.amount}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
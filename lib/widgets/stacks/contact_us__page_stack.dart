import 'package:flutter/material.dart';
import '../../old/footer.dart';
import '../Contact.dart';

class ContactUsPageStack extends StatelessWidget {
  const ContactUsPageStack({super.key, required this.onTabSelected});
  final void Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.blue.shade50,
        child: Column(
          children: [
            ContactPage(),
            Footer(onTabSelected: onTabSelected),
          ],
        ),
      ),
    );
  }
}

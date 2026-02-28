import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import '../../services/contact_service.dart';
import 'widget/contact_info.dart';
import 'widget/contact_form.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _service = ContactService();

  void showFlushBar(BuildContext context, String msg, {bool success = true}) {
    Flushbar(
      messageText: Text(
        msg,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      maxWidth: 400,
      duration: const Duration(seconds: 4),
      backgroundColor: success ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      icon: Icon(
        success ? Icons.check_circle_outline : Icons.error_outline,
        color: Colors.white,
        size: 28,
      ),
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1000;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          const BackgroundCanvas(),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? size.width * 0.08 : 24,
                vertical: 60,
              ),
              child: Column(
                children: [
                  const PageHeader(),
                  const SizedBox(height: 60),
                  isDesktop
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ContactForm(
                          onSubmit: (name, email, message) {
                            return _service.sendMessage(name, email, message);
                          },
                          showMessage: (msg, {bool success = true}) {
                            showFlushBar(context, msg, success: success);
                          },
                        ),
                      ),
                      const SizedBox(width: 80),
                      Expanded(flex: 2, child: const  ContactInfoSection()),
                    ],
                  )
                      : Column(
                    children: [
                      ContactForm(
                        onSubmit: (name, email, message) {
                          return _service.sendMessage(name, email, message);
                        },
                        showMessage: (msg, {bool success = true}) {
                          showFlushBar(context, msg, success: success);
                        },
                      ),
                      const SizedBox(height: 60),
                      const ContactInfoSection(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            "Reach Out to Us",
            style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.w800, letterSpacing: 1.5, fontSize: 12),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Let’s create the future\ntogether.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
      ],
    );
  }
}

class BackgroundCanvas extends StatelessWidget {
  const BackgroundCanvas({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -100,
          child: _BlurBlob(color: const Color(0xFFDBEAFE), size: 500),
        ),
        Positioned(
          bottom: -100,
          left: -100,
          child: _BlurBlob(color: const Color(0xFFEFF6FF), size: 400),
        ),
      ],
    );
  }
}

class _BlurBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _BlurBlob({required this.color, required this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container(color: Colors.transparent)),
    );
  }
}

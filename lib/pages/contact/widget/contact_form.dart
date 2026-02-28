import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A professional-grade contact form with validation,
/// loading states, and optimized UX.
class ContactForm extends StatefulWidget {
  final Future<bool> Function(String name, String email, String message) onSubmit;
  final void Function(String message, {bool success}) showMessage;

  const ContactForm({
    super.key,
    required this.onSubmit,
    required this.showMessage,
  });

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _messageController;

  // Focus Nodes
  late final FocusNode _nameFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _msgFocus;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _msgFocus = FocusNode();
  }

  @override
  void dispose() {
    for (var controller in [_nameController, _emailController, _messageController]) {
      controller.dispose();
    }
    for (var node in [_nameFocus, _emailFocus, _msgFocus]) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (_isLoading) return;

    if (!(_formKey.currentState?.validate() ?? false)) {
      HapticFeedback.vibrate();
      return;
    }

    _formKey.currentState?.save();
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      final success = await widget.onSubmit(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _messageController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        _formKey.currentState?.reset();
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        widget.showMessage("Message sent successfully!", success: true);
      } else {
        widget.showMessage("Could not send message. Please try again.", success: false);
      }
    } catch (e) {
      widget.showMessage("An unexpected error occurred.", success: false);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeaderSection(),
                const SizedBox(height: 32),

                _CustomTextField(
                  label: "Full Name",
                  controller: _nameController,
                  focusNode: _nameFocus,
                  hint: "Jane Doe",
                  autofillHints: const [AutofillHints.name],
                  validator: _Validators.required,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 24),

                _CustomTextField(
                  label: "Email Address",
                  controller: _emailController,
                  focusNode: _emailFocus,
                  hint: "jane@example.com",
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  validator: _Validators.email,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 24),

                _CustomTextField(
                  label: "Message",
                  controller: _messageController,
                  focusNode: _msgFocus,
                  hint: "Tell us how we can help...",
                  maxLines: 5,
                  validator: _Validators.required,
                  textInputAction: TextInputAction.newline,
                ),

                const SizedBox(height: 40),

                _SubmitButton(
                  isLoading: _isLoading,
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Connect with us",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Reach out to our team. We'll respond as soon as possible.",
          style: TextStyle(
            color: const Color(0xFF64748B),
            fontSize: 15,
            height: 1.5, // Improves readability
          ),
        ),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final int maxLines;

  const _CustomTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
              letterSpacing: 0.2,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          maxLines: maxLines,
          cursorColor: Colors.black45,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w400),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.all(18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black45, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black45, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _SubmitButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F172A),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
        )
            : const Text("Send Message"),
      ),
    );
  }
}

class _Validators {
  static String? required(String? value) {
    return (value == null || value.trim().isEmpty) ? "This field is required" : null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Please enter a valid email address";
    return null;
  }
}
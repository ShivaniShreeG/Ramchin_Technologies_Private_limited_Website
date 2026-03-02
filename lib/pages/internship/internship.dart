import 'package:flutter/material.dart';
import 'widget/project_overview.dart';

class InternshipPage extends StatefulWidget {
  const InternshipPage({super.key});

  @override
  State<InternshipPage> createState() => _InternshipPageState();
}

class _InternshipPageState extends State<InternshipPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children:  [
            ProjectPreview(),
          ],
        ),
      ),

      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToTop ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: _showScrollToTop
            ? FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: Colors.white,
          child: const Icon(Icons.keyboard_arrow_up, size: 30,color: Colors.blueAccent,),
        )
            : null,
      ),
    );
  }
}
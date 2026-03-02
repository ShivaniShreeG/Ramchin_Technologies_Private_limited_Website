import 'package:flutter/material.dart';
import 'header.dart';
import 'projects.dart';
import 'tech_stack.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollTop) {
        setState(() => _showScrollTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollTop) {
        setState(() => _showScrollTop = false);
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
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          // 🔹 Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: const [
                SizedBox(height: 8),
                InternshipHeader(),
                SizedBox(height: 12),
                MemberCardGrid(),
                SizedBox(height: 12),
                TechStackGrid(),
                SizedBox(height: 24),
              ],
            ),
          ),

          // 🔙 Back Button (Top Left)
          Positioned(
            top: 20,
            left: 16,
            child: FloatingActionButton(
              heroTag: 'backBtn',
              mini: true,
              backgroundColor: Colors.white,
              elevation: 4,
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Colors.blueAccent,
              ),
            ),
          ),

          Positioned(
            bottom: 24,
            right: 24,
            child: AnimatedOpacity(
              opacity: _showScrollTop ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: _showScrollTop
                  ? FloatingActionButton(
                heroTag: 'scrollTop',
                backgroundColor: Colors.white,
                elevation: 6,
                onPressed: _scrollToTop,
                child: const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  size: 30,
                  color: Colors.blueAccent,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
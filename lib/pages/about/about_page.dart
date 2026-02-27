import 'package:flutter/material.dart';
import 'widget/management_member.dart';
import 'widget/who_are_we.dart';
import 'widget/mission_vision.dart';
import 'widget/technical_team.dart';
import 'widget/our_story.dart';
import 'widget/our_goals.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
            WhoWeAreSection(),
            MissionVisionSection(),
            OurGoalsSection(),
            MemberSection(),
            TeamSection(),
            OurStorySection(),
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
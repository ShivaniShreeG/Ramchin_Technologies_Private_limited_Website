import 'package:flutter/material.dart';

import '../InternProjects.dart';
import '../../old/VisionCard.dart';

class ProjectPageStack extends StatelessWidget {
  const ProjectPageStack({super.key});

  @override
  Widget build(BuildContext context) {
    const int visionNum = 2;

    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 8),
          InternshipHeader(),
          SizedBox(height: 6),
          VisionCarousel(visionNum: visionNum),
          SizedBox(height: 12),    // less gap above members
          MemberCardGrid(),
          SizedBox(height: 12),    // less gap below members
          TechStackGrid(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

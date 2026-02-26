import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'team_member.dart';

class TeamDetailPage extends StatelessWidget {
  final TeamMember member;

  const TeamDetailPage({super.key, required this.member});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xfff1b9a0),
                    Color(0xfff9d5c4)
                  ],
                ),
              ),
              child: Center(
                child: Hero(
                  tag: member.name,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage:
                    AssetImage(member.imageUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(member.name,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(member.role,
                style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xfff1b9a0))),
            const SizedBox(height: 40),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text("About",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(member.description),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          _launch(member.resumeUrl),
                      icon:
                      const Icon(Icons.picture_as_pdf),
                      label:
                      const Text("View Resume"),
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xfff1b9a0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

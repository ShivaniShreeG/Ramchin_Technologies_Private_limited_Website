import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/apiservice.dart';
import 'coursedetailpage.dart';
import 'contact_us.dart' as contact_us;
import 'terms.dart' as terms;
import 'policy.dart' as policy;

class InternshipPage extends StatefulWidget {
  const InternshipPage({super.key});

  @override
  State<InternshipPage> createState() => _HomePageState();
}

class _HomePageState extends State<InternshipPage> {
  late Future<List<dynamic>> futureCourses;

  final Map<String, String> titleToLogo = {
    "Flutter": "flutter.png",
    "Node JS": "nodejs.png",
    "React": "react.png",
    "C++": "c++.png",
  };

  bool _hoverContact = false;
  bool _hoverTerms = false;
  bool _hoverPrivacy = false;

  @override
  void initState() {
    super.initState();
    futureCourses = ApiService.getCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: 450,
                    height: 90,
                    child: Image.asset(
                      'ramchinlogob.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Empowering developers through quality education!",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Internships",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FutureBuilder<List<dynamic>>(
                            future: futureCourses,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 28.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final courses = snapshot.data!;
                              if (courses.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 24.0),
                                  child: Center(
                                      child: Text("No courses available")),
                                );
                              }

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: courses.map((c) {
                                    final String title = c["title"] ?? "";
                                    final String? logoFile = titleToLogo[title];
                                    final int courseId =
                                        int.tryParse(c['id'].toString()) ?? 1;

                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(right: 12),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(160, 46),
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.white,
                                          elevation: 2,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CourseDetailPage(
                                                    courseId: courseId,
                                                    name: c['title']?.toString(),
                                                    amount: double.tryParse(
                                                        c['price']
                                                            ?.toString() ??
                                                            '0') ??
                                                        0.0,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (logoFile != null)
                                              Image.asset(
                                                'assets/$logoFile',
                                                width: 28,
                                                height: 28,
                                              )
                                            else
                                              const Icon(
                                                Icons.image_not_supported,
                                                color: Colors.grey,
                                                size: 28,
                                              ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      Text(
                        "Invest in your career",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Flexible(
                            child: Column(
                              children: [
                                Text(
                                  "Explore new skills",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Access Courses and Learn new skills",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const Flexible(
                            child: Column(
                              children: [
                                Text(
                                  "Earn valuable credentials",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Get certificates for every course you finish and boost your \nchances of getting hired after your trial ends at no additional cost.",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Text(
                        "Why Choose Us?",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 18),
                      const SizedBox(height: 18),

                      Center(
                        child: SizedBox(
                          width: 500,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              ListTile(
                                leading: Icon(Icons.school,
                                    color: Colors.blue, size: 34),
                                title: Text("Expert-Led Courses",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Learn from industry professionals with real-world experience."),
                              ),
                              ListTile(
                                leading: Icon(Icons.work,
                                    color: Colors.blue, size: 34),
                                title: Text("Job-Ready Skills",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Gain practical skills that employers are looking for."),
                              ),
                              ListTile(
                                leading: Icon(Icons.lightbulb_outline,
                                    color: Colors.blue, size: 34),
                                title: Text("Internship Opportunities",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Apply your knowledge in real projects and gain valuable experience."),
                              ),
                              ListTile(
                                leading: Icon(Icons.people,
                                    color: Colors.blue, size: 34),
                                title: Text("Supportive Community",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text(
                                    "Connect with fellow learners and mentors."),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _hoverContact = true),
                  onExit: (_) => setState(() => _hoverContact = false),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(160, 46),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const contact_us.ContactUsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: _hoverContact
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _hoverTerms = true),
                  onExit: (_) => setState(() => _hoverTerms = false),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(160, 46),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const terms.TermsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: _hoverTerms
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _hoverPrivacy = true),
                  onExit: (_) => setState(() => _hoverPrivacy = false),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(160, 46),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const policy.PrivacyPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: _hoverPrivacy
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
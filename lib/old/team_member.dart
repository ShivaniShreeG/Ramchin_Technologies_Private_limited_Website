class TeamMember {
  final String name;
  final String role;
  final String imageUrl;
  final String bio;
  final String description;
  final List<String> projects;
  final List<String> experience;
  final String resumeUrl;
  final String linkedinUrl;
  final String githubUrl;
  final String upworkUrl;
  final List<String> reviews;

  TeamMember({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.bio,
    required this.description,
    required this.projects,
    required this.experience,
    required this.resumeUrl,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.upworkUrl,
    required this.reviews,
  });
}

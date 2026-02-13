class Course {
  final int id;
  final String title;
  final String image;
  final String description;
  final double price;

  Course({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as num).toDouble(),
    );
  }
}
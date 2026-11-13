class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'] is Map
        ? json['rating'] as Map
        : {};

    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? 'Unknown product',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description:
      json['description']?.toString() ?? 'No description',
      category: json['category']?.toString() ?? 'Other',
      imageUrl: json['image']?.toString() ?? '',
      rating:
      (ratingData['rate'] as num?)?.toDouble() ?? 0.0,
      reviewCount:
      (ratingData['count'] as num?)?.toInt() ?? 0,
    );
  }
}

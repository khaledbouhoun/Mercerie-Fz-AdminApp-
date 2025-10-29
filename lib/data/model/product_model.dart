class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final int categoryId;
  final double? rating;
  final int? reviewCount;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    this.rating,
    this.reviewCount,
    this.isAvailable = true,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      categoryId: json['category_id'] ?? 0,
      rating: double.tryParse(json['rating']?.toString() ?? '0'),
      reviewCount: json['review_count'],
      isAvailable: json['is_available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image_url': imageUrl,
      'category_id': categoryId,
      'rating': rating,
      'review_count': reviewCount,
      'is_available': isAvailable,
    };
  }
}

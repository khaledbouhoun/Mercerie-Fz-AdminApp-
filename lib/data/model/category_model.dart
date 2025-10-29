class Category {
  final int id;
  final String name;
  final String? imageUrl;
  final int productCount;
  final String? description;

  Category({required this.id, required this.name, this.imageUrl, this.productCount = 0, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['image_url'],
      productCount: json['product_count'] ?? 0,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image_url': imageUrl, 'product_count': productCount, 'description': description};
  }
}

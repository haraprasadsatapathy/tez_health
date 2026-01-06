import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String categoryId;
  final String name;
  final String image;
  final String imageUrl;
  final String description;

  const Category({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.imageUrl,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      'image': image,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [categoryId, name, image, imageUrl, description];
}

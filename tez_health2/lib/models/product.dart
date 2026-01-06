import 'package:equatable/equatable.dart';
import 'product_variant.dart';

class Product extends Equatable {
  final String productId;
  final String name;
  final String description;
  final String categoryId;
  final String image;
  final String imageUrl;
  final List<ProductVariant> variants;

  const Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.image,
    required this.imageUrl,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var variantsList = json['variants'] as List? ?? [];
    List<ProductVariant> variants = variantsList
        .map((variantJson) => ProductVariant.fromJson(variantJson))
        .toList();

    return Product(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      image: json['image'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      variants: variants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'image': image,
      'imageUrl': imageUrl,
      'variants': variants.map((v) => v.toJson()).toList(),
    };
  }

  ProductVariant? get firstVariant => variants.isNotEmpty ? variants.first : null;

  @override
  List<Object?> get props => [
        productId,
        name,
        description,
        categoryId,
        image,
        imageUrl,
        variants,
      ];
}

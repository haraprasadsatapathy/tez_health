import 'package:equatable/equatable.dart';
import 'product_variant.dart';


class Product extends Equatable {
  final String productId;
  final String name;
  final String description;
  final String longDescription;
  final String? categoryId;
  final String? image;
  final String imageUrl;
  final String? seoSlug;
  final List<ProductVariant> variants;
  final List<RelatedProduct> relatedProducts;

  const Product({
    required this.productId,
    required this.name,
    required this.description,
    this.longDescription = '',
    this.categoryId,
    this.image,
    required this.imageUrl,
    this.seoSlug,
    required this.variants,
    this.relatedProducts = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Handle nested data object if present
    var productData = json['data'] ?? json;

    var variantsList = productData['variants'] as List? ?? [];
    List<ProductVariant> variants = variantsList
        .map((variantJson) => ProductVariant.fromJson(variantJson))
        .toList();

    var relatedProductsList = productData['relatedProducts'] as List? ?? [];
    List<RelatedProduct> relatedProducts = relatedProductsList
        .map((relatedJson) => RelatedProduct.fromJson(relatedJson))
        .toList();

    return Product(
      productId: productData['productId'] ?? '',
      name: productData['name'] ?? '',
      description: productData['description'] ?? '',
      longDescription: productData['longDescription'] ?? '',
      categoryId: productData['categoryId'],
      image: productData['image'],
      imageUrl: productData['imageUrl'] ?? '',
      seoSlug: productData['seoSlug'],
      variants: variants,
      relatedProducts: relatedProducts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'longDescription': longDescription,
      'categoryId': categoryId,
      'image': image,
      'imageUrl': imageUrl,
      'seoSlug': seoSlug,
      'variants': variants.map((v) => v.toJson()).toList(),
      'relatedProducts': relatedProducts.map((r) => r.toJson()).toList(),
    };
  }

  ProductVariant? get firstVariant => variants.isNotEmpty ? variants.first : null;

  @override
  List<Object?> get props => [
    productId,
    name,
    description,
    longDescription,
    categoryId,
    image,
    imageUrl,
    seoSlug,
    variants,
    relatedProducts,
  ];
}


class RelatedProduct extends Equatable {
  final String productId;
  final String name;
  final String description;
  final String categoryId;
  final String imageUrl;
  final String seoSlug;
  final String targetCity;

  const RelatedProduct({
    required this.productId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.imageUrl,
    required this.seoSlug,
    required this.targetCity,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      seoSlug: json['seoSlug'] ?? '',
      targetCity: json['targetCity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'seoSlug': seoSlug,
      'targetCity': targetCity,
    };
  }

  @override
  List<Object?> get props => [
    productId,
    name,
    description,
    categoryId,
    imageUrl,
    seoSlug,
    targetCity,
  ];
}



// import 'package:equatable/equatable.dart';
// import 'product_variant.dart';
//
// class Product extends Equatable {
//   final String productId;
//   final String name;
//   final String description;
//   final String longDescription;
//   final String categoryId;
//   final String image;
//   final String imageUrl;
//   final List<ProductVariant> variants;
//
//   const Product({
//     required this.productId,
//     required this.name,
//     required this.description,
//     this.longDescription = '',
//     required this.categoryId,
//     required this.image,
//     required this.imageUrl,
//     required this.variants,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     var variantsList = json['variants'] as List? ?? [];
//     List<ProductVariant> variants = variantsList
//         .map((variantJson) => ProductVariant.fromJson(variantJson))
//         .toList();
//
//     return Product(
//       productId: json['productId'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       longDescription: json['longDescription'] ?? '',
//       categoryId: json['categoryId'] ?? '',
//       image: json['image'] ?? '',
//       imageUrl: json['imageUrl'] ?? '',
//       variants: variants,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'productId': productId,
//       'name': name,
//       'description': description,
//       'longDescription': longDescription,
//       'categoryId': categoryId,
//       'image': image,
//       'imageUrl': imageUrl,
//       'variants': variants.map((v) => v.toJson()).toList(),
//     };
//   }
//
//   ProductVariant? get firstVariant => variants.isNotEmpty ? variants.first : null;
//
//   @override
//   List<Object?> get props => [
//         productId,
//         name,
//         description,
//         longDescription,
//         categoryId,
//         image,
//         imageUrl,
//         variants,
//       ];
// }

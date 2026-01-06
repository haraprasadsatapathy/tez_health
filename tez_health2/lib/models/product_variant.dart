import 'package:equatable/equatable.dart';

class ProductVariant extends Equatable {
  final String variantId;
  final String productId;
  final String variantName;
  final double price;
  final double discountPrice;

  const ProductVariant({
    required this.variantId,
    required this.productId,
    required this.variantName,
    required this.price,
    required this.discountPrice,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      variantId: json['variantId'] ?? '',
      productId: json['productId'] ?? '',
      variantName: json['variantName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: (json['discountPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variantId': variantId,
      'productId': productId,
      'variantName': variantName,
      'price': price,
      'discountPrice': discountPrice,
    };
  }

  double get discountPercentage {
    if (price <= 0) return 0;
    return ((price - discountPrice) / price) * 100;
  }

  @override
  List<Object?> get props => [variantId, productId, variantName, price, discountPrice];
}

import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String name;
  final String productId;

  const SearchResult({
    required this.name,
    required this.productId,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      name: json['name'] ?? '',
      productId: json['productId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productId': productId,
    };
  }

  @override
  List<Object?> get props => [name, productId];
}

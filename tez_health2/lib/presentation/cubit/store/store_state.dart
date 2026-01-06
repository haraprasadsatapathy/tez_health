import '../../../models/product.dart';
import '../base_event_state.dart';

class StoreState extends BaseState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  const StoreState({
    this.products = const [],
    this.filteredProducts = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  StoreState copyWith({
    List<Product>? products,
    List<Product>? filteredProducts,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return StoreState(
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        products,
        filteredProducts,
        isLoading,
        errorMessage,
        searchQuery,
      ];
}

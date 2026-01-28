import '../base_event_state.dart';
import '../../../models/product.dart';

abstract class ProductState extends BaseEventState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductLoaded extends ProductState {
  final Product product;
  final List<Product> relatedProducts;

  const ProductLoaded(this.product, {this.relatedProducts = const []});

  @override
  List<Object?> get props => [product, relatedProducts];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

import '../base_event_state.dart';

abstract class ProductEvent extends BaseEventState {
  const ProductEvent();
}

class FetchProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  const FetchProductsByCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class FetchProductByIdEvent extends ProductEvent {
  final String productId;

  const FetchProductByIdEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

// class FetchAllProductsEvent extends ProductEvent {
//   const FetchAllProductsEvent();
// }

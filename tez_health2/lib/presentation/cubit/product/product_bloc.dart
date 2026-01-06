import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final TezRepository _repository;

  ProductBloc(this._repository) : super(const ProductInitial()) {
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
    on<FetchProductByIdEvent>(_onFetchProductById);
    on<FetchAllProductsEvent>(_onFetchAllProducts);
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(const ProductLoading());
      final products = await _repository.fetchProductsByCategory(event.categoryId);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProductById(
    FetchProductByIdEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(const ProductLoading());
      final product = await _repository.getProductById(event.productId);
      if (product != null) {
        emit(ProductLoaded(product));
      } else {
        emit(const ProductError('Product not found'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchAllProducts(
    FetchAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(const ProductLoading());
      final products = await _repository.fetchAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

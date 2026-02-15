import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import '../../../models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final TezRepository _repository;

  ProductBloc(this._repository) : super(const ProductInitial()) {
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
    on<FetchProductByIdEvent>(_onFetchProductById);
    // on<FetchAllProductsEvent>(_onFetchAllProducts);
  }
  // From anywhere in your app


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
        // Fetch related products - try category first, then all products
        List<Product> relatedProducts = [];
        try {
          // First try to get products from the same category
          if (product.categoryId!.isNotEmpty) {
            final categoryProducts = await _repository.fetchProductsByCategory(product.categoryId!);
            relatedProducts = categoryProducts
                .where((p) => p.productId != product.productId)
                .toList();
          }

          // If no category products found, fetch all products
          // if (relatedProducts.isEmpty) {
          //   final allProducts = await _repository.fetchAllProducts();
          //   relatedProducts = allProducts
          //       .where((p) => p.productId != product.productId)
          //       .toList();
          // }
        } catch (e) {
          // If fetching related products fails, try fetching all products
          // try {
          //   final allProducts = await _repository.fetchAllProducts();
          //   relatedProducts = allProducts
          //       .where((p) => p.productId != product.productId)
          //       .toList();
          // } catch (_) {
          //   relatedProducts = [];
          // }
        }
        emit(ProductLoaded(product, relatedProducts: relatedProducts));
      } else {
        emit(const ProductError('Product not found'));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  // Future<void> _onFetchAllProducts(
  //   FetchAllProductsEvent event,
  //   Emitter<ProductState> emit,
  // ) async {
  //   try {
  //     emit(const ProductLoading());
  //     final products = await _repository.fetchAllProducts();
  //     emit(ProductsLoaded(products));
  //   } catch (e) {
  //     emit(ProductError(e.toString()));
  //   }
  // }
}

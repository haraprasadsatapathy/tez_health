import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import 'store_event.dart';
import 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final TezRepository _repository;

  StoreBloc(this._repository) : super(const StoreState()) {
    on<LoadStoreEvent>(_onLoadStore);
    on<RefreshStoreEvent>(_onRefreshStore);
    on<SearchStoreProductsEvent>(_onSearchProducts);
  }

  Future<void> _onLoadStore(
    LoadStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Fetch all products for the store
      final products = await _repository.fetchAllProducts();
      emit(state.copyWith(
        products: products,
        filteredProducts: products,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load store products: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRefreshStore(
    RefreshStoreEvent event,
    Emitter<StoreState> emit,
  ) async {
    try {
      final products = await _repository.fetchAllProducts();
      emit(state.copyWith(
        products: products,
        filteredProducts: products,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to refresh store products: ${e.toString()}',
      ));
    }
  }

  void _onSearchProducts(
    SearchStoreProductsEvent event,
    Emitter<StoreState> emit,
  ) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        filteredProducts: state.products,
        searchQuery: '',
      ));
      return;
    }

    final filtered = state.products.where((product) {
      return product.name.toLowerCase().contains(query) ||
          (product.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    emit(state.copyWith(
      filteredProducts: filtered,
      searchQuery: query,
    ));
  }
}

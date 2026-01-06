import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final TezRepository _repository;

  CategoriesBloc(this._repository) : super(const CategoriesState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<RefreshCategoriesEvent>(_onRefreshCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final categories = await _repository.fetchCategories();
      emit(state.copyWith(
        categories: categories,
        filteredCategories: categories,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load categories: ${e.toString()}',
      ));
    }
  }

  Future<void> _onRefreshCategories(
    RefreshCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      final categories = await _repository.fetchCategories();
      emit(state.copyWith(
        categories: categories,
        filteredCategories: categories,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to refresh categories: ${e.toString()}',
      ));
    }
  }

  void _onSearchCategories(
    SearchCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        filteredCategories: state.categories,
        searchQuery: '',
      ));
      return;
    }

    final filtered = state.categories.where((category) {
      return category.name.toLowerCase().contains(query) ||
          (category.description?.toLowerCase().contains(query) ?? false);
    }).toList();

    emit(state.copyWith(
      filteredCategories: filtered,
      searchQuery: query,
    ));
  }
}

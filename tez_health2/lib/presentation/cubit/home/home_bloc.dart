import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TezRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
    on<SearchProductsEvent>(_onSearchProducts);
    // on<FetchPopularServiceEvent>(_onPopularService);
  }

  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(const HomeLoading());
      final categories = await _repository.fetchCategories();
      final popularService = await _repository.fetchPopularService();
      emit(CategoriesLoaded(categories,popularService));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onPopularService(
    FetchPopularServiceEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(const HomeLoading());
      final popularService = await _repository.fetchPopularService();
      emit(PopularServiceDataLoaded(popularService));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.keywords.length < 2) {
        emit(const SearchResultsLoaded([]));
        return;
      }
      final results = await _repository.searchProducts(event.keywords);
      emit(SearchResultsLoaded(results));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

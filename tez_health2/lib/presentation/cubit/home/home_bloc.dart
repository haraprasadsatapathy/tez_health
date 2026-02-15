import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/tez_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TezRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<FetchHomeDataEvent>(_onFetchHomeData);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchHomeData(
    FetchHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(const HomeLoading());
      final categoriesFuture = _repository.fetchCategories();
      final popularServicesFuture = _repository.fetchPopularService();

      final categories = await categoriesFuture;
      final popularServices = await popularServicesFuture;

      emit(HomeDataLoaded(
        categories: categories,
        popularServices: popularServices,
      ));
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

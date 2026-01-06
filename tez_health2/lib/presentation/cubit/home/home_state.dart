import '../base_event_state.dart';
import '../../../models/category.dart';
import '../../../models/search_result.dart';

abstract class HomeState extends BaseEventState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class CategoriesLoaded extends HomeState {
  final List<Category> categories;

  const CategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class SearchResultsLoaded extends HomeState {
  final List<SearchResult> results;

  const SearchResultsLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

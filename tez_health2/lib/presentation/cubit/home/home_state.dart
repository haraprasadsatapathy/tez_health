import '../../../models/popular_service_response.dart';
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

class HomeDataLoaded extends HomeState {
  final List<Category> categories;
  final List<PopularServiceData> popularServices;

  const HomeDataLoaded({
    required this.categories,
    required this.popularServices,
  });

  HomeDataLoaded copyWith({
    List<Category>? categories,
    List<PopularServiceData>? popularServices,
  }) {
    return HomeDataLoaded(
      categories: categories ?? this.categories,
      popularServices: popularServices ?? this.popularServices,
    );
  }

  @override
  List<Object?> get props => [categories, popularServices];
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

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

class CategoriesLoaded extends HomeState {
  final List<Category> categories;
  final List<PopularServiceData> popularServiceData;
  const CategoriesLoaded(this.categories,this.popularServiceData);


}

class PopularServiceDataLoaded extends HomeState {
  final List<PopularServiceData> popularServiceData;

  const PopularServiceDataLoaded(this.popularServiceData);

  @override
  List<Object?> get props => [PopularServiceData];
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

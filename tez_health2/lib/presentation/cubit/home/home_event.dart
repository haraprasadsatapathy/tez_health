import '../base_event_state.dart';

abstract class HomeEvent extends BaseEventState {
  const HomeEvent();
}

class FetchPopularServiceEvent extends HomeEvent {
  const FetchPopularServiceEvent();
}

class FetchCategoriesEvent extends HomeEvent {
  const FetchCategoriesEvent();
}

class SearchProductsEvent extends HomeEvent {
  final String keywords;

  const SearchProductsEvent(this.keywords);

  @override
  List<Object?> get props => [keywords];
}

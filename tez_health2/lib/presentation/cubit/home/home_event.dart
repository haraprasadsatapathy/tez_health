import '../base_event_state.dart';

abstract class HomeEvent extends BaseEventState {
  const HomeEvent();
}

class FetchHomeDataEvent extends HomeEvent {
  const FetchHomeDataEvent();
}

class SearchProductsEvent extends HomeEvent {
  final String keywords;

  const SearchProductsEvent(this.keywords);

  @override
  List<Object?> get props => [keywords];
}

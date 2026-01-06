import '../base_event_state.dart';

abstract class CategoriesEvent extends BaseEvent {
  const CategoriesEvent();
}

class LoadCategoriesEvent extends CategoriesEvent {
  const LoadCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class RefreshCategoriesEvent extends CategoriesEvent {
  const RefreshCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class SearchCategoriesEvent extends CategoriesEvent {
  final String query;

  const SearchCategoriesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

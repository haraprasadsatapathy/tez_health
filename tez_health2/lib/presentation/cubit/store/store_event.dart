import '../base_event_state.dart';

abstract class StoreEvent extends BaseEvent {
  const StoreEvent();
}

class LoadStoreEvent extends StoreEvent {
  const LoadStoreEvent();

  @override
  List<Object?> get props => [];
}

class RefreshStoreEvent extends StoreEvent {
  const RefreshStoreEvent();

  @override
  List<Object?> get props => [];
}

class SearchStoreProductsEvent extends StoreEvent {
  final String query;

  const SearchStoreProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

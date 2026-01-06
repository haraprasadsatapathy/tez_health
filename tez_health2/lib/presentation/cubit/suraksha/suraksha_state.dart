import '../base_event_state.dart';

class SurakshaState extends BaseState {
  final bool isLoading;
  final String? errorMessage;
  final List<dynamic> surakshaItems;

  const SurakshaState({
    this.isLoading = false,
    this.errorMessage,
    this.surakshaItems = const [],
  });

  SurakshaState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<dynamic>? surakshaItems,
  }) {
    return SurakshaState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      surakshaItems: surakshaItems ?? this.surakshaItems,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, surakshaItems];
}

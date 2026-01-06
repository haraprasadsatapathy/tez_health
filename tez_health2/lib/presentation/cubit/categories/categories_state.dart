import '../../../models/category.dart';
import '../base_event_state.dart';

class CategoriesState extends BaseState {
  final List<Category> categories;
  final List<Category> filteredCategories;
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;

  const CategoriesState({
    this.categories = const [],
    this.filteredCategories = const [],
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
  });

  CategoriesState copyWith({
    List<Category>? categories,
    List<Category>? filteredCategories,
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        filteredCategories,
        isLoading,
        errorMessage,
        searchQuery,
      ];
}

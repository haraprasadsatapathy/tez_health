import '../../data/api_client/api_client.dart';
import '../../models/category.dart';
import '../../models/popular_service_response.dart';
import '../../models/product.dart';
import '../../models/search_result.dart';
import '../../models/booking_request.dart';
import '../../models/booking_response.dart';
import '../../utils/app_constants.dart';

class TezRepository {
  final ApiClient _apiClient;

  TezRepository(this._apiClient);

  // Fetch all categories
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _apiClient.get(AppConstants.fetchCategoriesEndpoint);
      final data = response.data;

      if (data != null && data['objret'] != null) {
        final List<dynamic> categoriesJson = data['objret'];
        return categoriesJson.map((json) => Category.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
  Future<List<PopularServiceData>> fetchPopularService() async {
    try {
      final response = await _apiClient.get(AppConstants.fetchPopularServiceEndpoint);
      final data = response.data;

      if (data != null && data['data'] != null) {
        final List<dynamic> servicesJson = data['data'];
        return servicesJson.map((json) => PopularServiceData.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  // Fetch all products
  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await _apiClient.get(AppConstants.fetchProductsEndpoint);
      final data = response.data;

      if (data != null && data['data'] != null) {
        final List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  // Fetch products by category
  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      final response = await _apiClient.get(
        AppConstants.fetchProductsByCategoryEndpoint,
        queryParameters: {'categoryid': categoryId},
      );
      final data = response.data;

      if (data != null && data['data'] != null) {
        final List<dynamic> productsJson = data['data'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  // Search products
  Future<List<SearchResult>> searchProducts(String keywords) async {
    try {
      final response = await _apiClient.get(
        AppConstants.searchProductsEndpoint,
        queryParameters: {'keywords': keywords},
      );
      final data = response.data;

      // Handle both response formats
      if (data is Map && data['data'] != null) {
        final List<dynamic> searchJson = data['data'];
        return searchJson.map((json) => SearchResult.fromJson(json)).toList();
      } else if (data is List) {
        return data.map((json) => SearchResult.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  // Get product by ID
  Future<Product?> getProductById(String productId) async {
    try {
      final response = await _apiClient.get(
        AppConstants.fetchProductDetailsByIdEndpoint,
        queryParameters: {'productid': productId},
      );
      final data = response.data;

      if (data != null && data['data'] != null) {
        return Product.fromJson(data['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Schedule callback
  Future<BookingResponse> scheduleCallback(BookingRequest request) async {
    try {
      final response = await _apiClient.post(
        AppConstants.bookingFormDetailEndpoint,
        data: request.toJson(),
      );

      if (response.data != null) {
        return BookingResponse.fromJson(response.data);
      }
      throw Exception('Invalid response from server');
    } catch (e) {
      rethrow;
    }
  }
}

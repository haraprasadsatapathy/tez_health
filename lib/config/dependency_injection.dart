import 'package:get_it/get_it.dart';
import '../services/storage_service.dart';
import '../services/location_service.dart';
import '../data/data_source/api_client.dart';
import '../domain/repository/emergency_repository.dart';

/// Dependency injection container
final GetIt getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> setupDependencyInjection() async {
  // Initialize StorageService first
  await StorageService.init();

  // Register Services (singletons)
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  // Register Emergency Repository (singleton)
  getIt.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepository(getIt<ApiClient>()),
  );
}

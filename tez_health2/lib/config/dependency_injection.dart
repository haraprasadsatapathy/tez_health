import 'package:get_it/get_it.dart';
import '../data/api_client/api_client.dart';
import '../domain/repository/tez_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Register ApiClient as singleton
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Register TezRepository as singleton
  getIt.registerLazySingleton<TezRepository>(
    () => TezRepository(getIt<ApiClient>()),
  );
}

import 'package:get_it/get_it.dart';

// Repositories
import 'package:cupboard/data/repositories/repositories.dart';

import 'package:cupboard/data/services/authentication_service.dart';

class DI {
  static final getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<FireUserDataRepository>(FireUserDataRepository());

    getIt.registerSingleton<FireCupboardRepository>(
        FireCupboardRepository(getIt<FireUserDataRepository>()));

    getIt.registerSingleton<FireCategoryRepository>(FireCategoryRepository());

    getIt.registerSingleton<FireProductRepository>(FireProductRepository());

    getIt.registerSingleton<FireProductItemRepository>(
        FireProductItemRepository());

    getIt.registerSingleton<AuthenticationService>(
        AuthenticationService(getIt<FireUserDataRepository>()));
  }
}

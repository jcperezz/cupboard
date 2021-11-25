import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/data/injectors/dependency_injector.dart';

import 'package:cupboard/data/repositories/repositories.dart';

import 'package:cupboard/domain/entities/product_item.dart';

// Notifiers
import 'package:cupboard/domain/notifiers/notifiers.dart';

// Screens
import 'package:cupboard/ui/screens/screens.dart';

final homeHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    final cupboardNotifier = DI.getIt<FireCupboardRepository>();
    final categoryNotifier = DI.getIt<FireCategoryRepository>();
    final productNotifier = DI.getIt<FireProductRepository>();

    final notifier = CupboardNotifier(
        authProvider.uid!, cupboardNotifier, categoryNotifier, productNotifier);

    return Layout(
        MultiProvider(
          child: CupboardsScreen(userUid: authProvider.uid!),
          providers: [
            ChangeNotifierProvider.value(value: notifier),
          ],
        ),
        title: "Cupboards");
  } else {
    return Layout(LoginScreen(), title: "Login", onlyBody: true);
  }
});

final registerHandler = Handler(handlerFunc: (context, params) {
  return Layout(RegisterScreen(), title: "Registro", onlyBody: true);
});

final newProductHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);
  final product = (ModalRoute.of(context)!.settings.arguments as ProductItem);

  String? cupboardUid = params['uid']?.first;

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    final categoryNotifier = CategoryNotifier(
      authProvider.uid,
      cupboardUid,
      DI.getIt<FireCategoryRepository>(),
    );
    final productNotifier = ProductItemNotifier(
      authProvider.uid,
      cupboardUid,
      DI.getIt<FireProductItemRepository>(),
    );

    return Layout(
      MultiProvider(
        child: ProductScreen(product: product, cupboardUid: cupboardUid!),
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider.value(value: productNotifier),
        ],
      ),
      title: product.id != null ? "Edit Product" : "New Product",
    );
  } else {
    return Layout(LoginScreen(), title: "Login", onlyBody: true);
  }
});

final inventoryHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  String? cupboardUid = params['uid']?.first;

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    final categoryNotifier = CategoryNotifier(
      authProvider.uid,
      cupboardUid,
      DI.getIt<FireCategoryRepository>(),
    );

    final productNotifier = ProductItemNotifier(
      authProvider.uid,
      cupboardUid,
      DI.getIt<FireProductItemRepository>(),
    );

    return Layout(
      MultiProvider(
        child: InventoryScreen(cupboardId: cupboardUid!),
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider.value(value: productNotifier),
        ],
      ),
      title: "Inventory",
    );
  } else {
    return Layout(LoginScreen(), title: "Login", onlyBody: true);
  }
});

class RouterManager {
  static final FluroRouter router = new FluroRouter();

  static void configureRoutes() {
    router.define('/',
        handler: homeHandler, transitionType: TransitionType.fadeIn);

    router.define('/home',
        handler: homeHandler, transitionType: TransitionType.fadeIn);

    router.define('/register',
        handler: registerHandler, transitionType: TransitionType.fadeIn);

    router.define('/inventory/:uid',
        handler: inventoryHandler, transitionType: TransitionType.fadeIn);

    router.define('/product/:uid',
        handler: newProductHandler, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = homeHandler;
  }
}

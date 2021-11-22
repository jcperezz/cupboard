import 'package:cupboard/data/repositories/cupboard/fire_cupboard_repository.dart';
import 'package:cupboard/domain/injectors/dependency_injector.dart';
import 'package:cupboard/domain/notifiers/category_notifier.dart';
import 'package:cupboard/domain/notifiers/cupboard_notifier.dart';
import 'package:cupboard/domain/notifiers/product_notifier.dart';
import 'package:cupboard/layouts/layout.dart';
import 'package:cupboard/ui/screens/products/products_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/screens/categories.dart';
import 'package:cupboard/screens/category.dart';
import 'package:cupboard/screens/cupboard.dart';
import 'package:cupboard/screens/home-grid.dart';
import 'package:cupboard/screens/loading.dart';
import 'package:cupboard/screens/login.dart';
import 'package:cupboard/screens/register.dart';

import 'package:cupboard/domain/notifiers/authentication_notifier.dart';

final homeHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    return Layout(
        MultiProvider(
          child: HomeGrid(),
          providers: [
            ChangeNotifierProvider.value(
                value: CupboardNotifier(FireCupboardRepository())),
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

final cupboardHandler = Handler(handlerFunc: (context, params) {
  String? uid = params['uid']?.first;

  return Layout(
      MultiProvider(
        child: CupboardScreen(uid: uid),
        providers: [
          ChangeNotifierProvider.value(
              value: DependencyInjector().get<CupboardNotifier>()),
        ],
      ),
      title: "Cupboards");
});

final categoriesHandler = Handler(handlerFunc: (context, params) {
  return Layout(CategoriesScreen(), title: "Cupboards");
});

final categoryHandler = Handler(handlerFunc: (context, params) {
  return Layout(CategoryScreen(), title: "Cupboards");
});

final productsHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  String? cupboardUid = params['uid']?.first;

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    final categoryNotifier = CategoryNotifier(authProvider.uid, cupboardUid);
    final productNotifier = ProductNotifier(authProvider.uid, cupboardUid);

    return Layout(
        MultiProvider(
          child: ProductsScreen(cupboardId: cupboardUid!),
          providers: [
            ChangeNotifierProvider.value(value: categoryNotifier),
            ChangeNotifierProvider.value(value: productNotifier),
          ],
        ),
        title: "Productos");
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

    router.define('/categories',
        handler: categoriesHandler, transitionType: TransitionType.fadeIn);

    router.define('/new-category',
        handler: categoryHandler, transitionType: TransitionType.fadeIn);

    router.define('/cupboard/:uid',
        handler: productsHandler, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = homeHandler;
  }
}

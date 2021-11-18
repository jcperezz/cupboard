import 'package:cupboard/domain/notifiers/category_notifier.dart';
import 'package:cupboard/domain/notifiers/product_notifier.dart';
import 'package:cupboard/layouts/layout.dart';
import 'package:cupboard/ui/screens/products/products_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/screens/categories.dart';
import 'package:cupboard/screens/category.dart';
import 'package:cupboard/screens/cupboard.dart';
import 'package:cupboard/screens/home-grid.dart';
import 'package:cupboard/screens/home.dart';
import 'package:cupboard/screens/loading.dart';
import 'package:cupboard/screens/login.dart';
import 'package:cupboard/screens/register.dart';

import 'package:cupboard/domain/notifiers/authentication_notifier.dart';

final homeHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    return Layout(HomeGrid(), title: "Cupboards");
  } else {
    return Layout(LoginScreen(), title: "Login", onlyBody: true);
  }
});

final registerHandler = Handler(handlerFunc: (context, params) {
  return Layout(RegisterScreen(), title: "Registro", onlyBody: true);
});

final cupboardHandler = Handler(handlerFunc: (context, params) {
  if (params['uid']?.first != null) {
    return Layout(CupboardScreen(uid: params['uid']!.first),
        title: "Cupboards");
  } else {
    return Layout(Home(), title: "Cupboards");
  }
});

final categoriesHandler = Handler(handlerFunc: (context, params) {
  return Layout(CategoriesScreen(), title: "Cupboards");
});

final categoryHandler = Handler(handlerFunc: (context, params) {
  return Layout(CategoryScreen(), title: "Cupboards");
});

final productsHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthenticationNotifier>(context!);

  if (authProvider.isLoading) {
    return Layout(LoadingScreen(), title: "Loading", onlyBody: true);
  } else if (authProvider.uid != null) {
    return Layout(
        MultiProvider(
          child: ProductsScreen(),
          providers: [
            ChangeNotifierProvider(
                create: (_) => CategoryNotifier(authProvider.uid)),
            ChangeNotifierProvider(
                create: (_) => ProductNotifier(authProvider.uid)),
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
        handler: cupboardHandler, transitionType: TransitionType.fadeIn);

    router.define('/products',
        handler: productsHandler, transitionType: TransitionType.fadeIn);

    router.notFoundHandler = homeHandler;
  }
}

import 'package:cupboard/screens/categories.dart';
import 'package:cupboard/screens/category.dart';
import 'package:cupboard/screens/home.dart';
import 'package:cupboard/screens/login.dart';
import 'package:cupboard/screens/register.dart';
import 'package:cupboard/services/user_service.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

final homeHandler = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<UserService>(context!);

  return authProvider.authStatus == AuthStatus.authenticated
      ? Home()
      : LoginScreen();
});

final registerHandler = Handler(handlerFunc: (context, params) {
  return RegisterScreen();
});

final categoriesHandler = Handler(handlerFunc: (context, params) {
  return CategoriesScreen();
});

final categoryHandler = Handler(handlerFunc: (context, params) {
  return CategoryScreen();
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

    router.notFoundHandler = homeHandler;
  }
}

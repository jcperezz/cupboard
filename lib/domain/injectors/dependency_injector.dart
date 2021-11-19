import 'package:cupboard/data/repositories/category/fire_category_repository.dart';
import 'package:cupboard/data/repositories/cupboard/fire_cupboard_repository.dart';
import 'package:cupboard/data/repositories/product/fire_product_repository.dart';
import 'package:cupboard/data/repositories/user/fire_user_repository.dart';
import 'package:cupboard/domain/notifiers/cupboard_notifier.dart';
import 'package:injector/injector.dart';

class DependencyInjector {
  void regist() {
    injector.registerDependency(() => FireCategoryRepository());
    injector.registerDependency(() => FireCupboardRepository());
    injector.registerDependency(() => FireProductRepository());
    injector.registerDependency(() => FireUserRepository());

    injector.registerSingleton(() {
      return CupboardNotifier(injector.get<FireCupboardRepository>());
    });
  }

  T get<T>({String name = ""}) => injector.get<T>(dependencyName: name);

  Injector get injector => Injector.appInstance;

  singleton<T>(T dependency, {String name = ""}) =>
      injector.registerSingleton(() => dependency, dependencyName: name);

  dependency<T>(T dependency, {String name = ""}) =>
      injector.registerSingleton(() => dependency, dependencyName: name);
}

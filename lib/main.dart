import 'package:cupboard/providers/local_storage_provider.dart';
import 'package:cupboard/routes/router.dart';
import 'package:cupboard/services/navigation_service.dart';
import 'package:cupboard/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/services/categories_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesProvider.init();

  RouterManager.configureRoutes();
  runApp(AppState());
}

/*
class MyFirebaseApp extends StatefulWidget {
  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            child: Text("Error al iniciar firebase ${snapshot.error}",
                textDirection: TextDirection.ltr),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return AppState();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
*/

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserService(), lazy: false),
        ChangeNotifierProvider(create: (_) => CategoriesService()),
        ChangeNotifierProvider(create: (_) => NavigationService())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cupboard',
      initialRoute: '/',
      onGenerateRoute: RouterManager.router.generator,
      //navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}

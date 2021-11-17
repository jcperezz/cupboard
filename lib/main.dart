import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:cupboard/routes/router.dart';

import 'package:cupboard/locale/labels_delegate.dart';
import 'package:cupboard/providers/local_storage_provider.dart';

import 'package:cupboard/services/authentication_service.dart';
import 'package:cupboard/services/cupboards_service.dart';
import 'package:cupboard/services/navigation_service.dart';
import 'package:cupboard/services/notifications_service.dart';
import 'package:cupboard/services/user_service.dart';
import 'package:cupboard/services/categories_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesProvider.init();

  RouterManager.configureRoutes();
  runApp(MyFirebaseApp());
}

class MyFirebaseApp extends StatefulWidget {
  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBPqmjAba0QRHkGLr7SRX8SBl8rDGNGTN8",
      authDomain: "cupboard-54d1c.firebaseapp.com",
      databaseURL: "https://cupboard-54d1c-default-rtdb.firebaseio.com",
      projectId: "cupboard-54d1c",
      storageBucket: "cupboard-54d1c.appspot.com",
      messagingSenderId: "1079318247904",
      appId: "1:1079318247904:web:d44e6909e446410aec5385",
    ),
  );

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

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(), lazy: false),
        ChangeNotifierProvider(create: (_) => UserService(), lazy: false),
        ChangeNotifierProvider(create: (_) => CategoriesService()),
        ChangeNotifierProvider(create: (_) => NavigationService()),
        ChangeNotifierProvider(create: (_) => CupboardsService()),
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
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light(),
      localizationsDelegates: const [
        LabelsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("es", ""),
        Locale("en", ""),
      ],
    );
  }
}

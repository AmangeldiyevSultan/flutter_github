import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/features/auth/services/auth_services.dart';
import 'package:flutter_github/features/splash/screens/splash_screen.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:flutter_github/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            brightness: Brightness.dark,
            fontFamily: 'SFPro',
            appBarTheme: const AppBarTheme(
                backgroundColor: kBackgroundColor,
                elevation: 1,
                shadowColor: Colors.white)),
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: const SplashScreen());
  }
}

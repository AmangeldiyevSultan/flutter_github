import 'package:flutter/material.dart';
import 'package:flutter_github/data/common/utils/colors.dart';
import 'package:flutter_github/data/repositories/auth_services.dart';
import 'package:flutter_github/ui/splash/splash_screen.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:flutter_github/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: 'Flutter GitHub',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            brightness: Brightness.dark,
            fontFamily: 'SFPro',
            appBarTheme: const AppBarTheme(
                backgroundColor: kBackgroundColor,
                elevation: 1,
                shadowColor: Colors.white)),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        onGenerateRoute: ((settings) => generateRoute(settings)),
        home: const SplashScreen());
  }
}

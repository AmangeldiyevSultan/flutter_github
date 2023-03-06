import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/features/auth/screens/auth_screen.dart';
import 'package:flutter_github/features/auth/services/auth_services.dart';
import 'package:flutter_github/features/repositories/screens/repositories_screen.dart';
import 'package:flutter_github/features/splash/screens/splash_screen.dart';
import 'package:flutter_github/providers/user_provider.dart';
import 'package:flutter_github/router.dart';
import 'package:provider/provider.dart';

void main() {
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
  void initState() {
    super.initState();
  }

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
      home: FutureBuilder(
          future: authService.getUserData(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Provider.of<UserProvider>(context, listen: true)
                      .userModel
                      .id
                      .isNotEmpty
                  ? const RepositoriesScreen()
                  : const AuthScreen();
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return const AuthScreen();
            }
            return const SplashScreen();
          }),
    );
  }
}

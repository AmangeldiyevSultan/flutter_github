import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/loader.dart';
import '../../../providers/user_provider.dart';
import '../../auth/screens/auth_screen.dart';
import '../../auth/services/auth_services.dart';
import '../../repositories/screens/repositories_screen.dart';

class SplashScreen extends StatefulWidget {
  final String? routeName;
  const SplashScreen({super.key, this.routeName});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authService.getUserData(context: context),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return const Scaffold(body: Loader());
          } else {
            FlutterNativeSplash.remove();
            if (snapshot.connectionState == ConnectionState.none) {
              return const AuthScreen();
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return Provider.of<UserProvider>(context, listen: true)
                            .userModel
                            .id !=
                        null
                    ? const RepositoriesScreen()
                    : const AuthScreen();
              }
            }
          }

          return const Scaffold(body: Loader());
        });
  }
}

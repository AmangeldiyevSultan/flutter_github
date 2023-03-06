import 'package:flutter/material.dart';
import 'package:flutter_github/features/auth/screens/auth_screen.dart';
import 'package:flutter_github/features/repositories/screens/repositories_screen.dart';
import 'package:flutter_github/features/repository_page/screens/create_issue_screen.dart';
import 'package:flutter_github/features/repository_page/screens/issues_page.dart';
import 'package:flutter_github/features/repository_page/screens/repository_screen.dart';
import 'package:flutter_github/models/repository_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case CreateIssueScreen.routeName:
      final repoUrl = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CreateIssueScreen(
                repoUrl: repoUrl,
              ));
    case RepositoriesScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const RepositoriesScreen());
    case IssuePage.routeName:
      final repoUrl = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => IssuePage(repoUrl: repoUrl));
    case RepositoryScreen.routeName:
      final repositoryModel = routeSettings.arguments as RepositoryModel;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => RepositoryScreen(
                repositoryModel: repositoryModel,
              ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen does not exist!"),
          ),
        ),
      );
  }
}

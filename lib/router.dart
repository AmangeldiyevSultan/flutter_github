import 'package:flutter/material.dart';
import 'package:flutter_github/ui/auth_page/auth_screen.dart';
import 'package:flutter_github/ui/repositories_page/repositories_screen.dart';
import 'package:flutter_github/ui/repository_page/create_issue_screen.dart';
import 'package:flutter_github/ui/repository_page/issues_screen.dart';
import 'package:flutter_github/ui/repository_page/repository_screen.dart';
import 'package:flutter_github/domains/models/repository_model.dart';

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
    case IssueScreen.routeName:
      final repoUrl = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => IssueScreen(repoUrl: repoUrl));
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

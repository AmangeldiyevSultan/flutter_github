import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/common/utils/git_language_color.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/common/widgets/error_state.dart';
import 'package:flutter_github/common/widgets/loader.dart';
import 'package:flutter_github/features/auth/services/auth_services.dart';
import 'package:flutter_github/features/repositories/services/repositories_services.dart';
import 'package:flutter_github/features/repository_page/screens/repository_screen.dart';
import 'package:flutter_github/models/repositories_model.dart';
import 'package:flutter_github/models/repository_model.dart';

class RepositoriesScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const RepositoriesScreen({super.key});

  @override
  State<RepositoriesScreen> createState() => _RepositoriesScreenState();
}

class _RepositoriesScreenState extends State<RepositoriesScreen> {
  AuthServices authServices = AuthServices();
  RepositoriesServices repositoriesServices = RepositoriesServices();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  // give form prog. language github color
  HexColor giveLangColor(String language) {
    String gitLangColor = gitLanguageColor[0].containsKey(language.toString())
        ? gitLanguageColor[0][language]!
        : '#FFFFFF';
    return HexColor(gitLangColor);
  }

  void navigateToRepositoryScreen(context, RepositoryModel repositoryModel) {
    Navigator.pushNamed(context, RepositoryScreen.routeName,
        arguments: repositoryModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Repositories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          //log out button
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                authServices.logOut(context: context);
              },
              child: const Icon(
                Icons.exit_to_app,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
          future: repositoriesServices.fetchRepositories(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return StateErrorCondition(
                stateEnum: StateEnum.connectionError,
                onTap: () {
                  setState(() {});
                },
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            if (snapshot.data!.totalCount == null) {
              return StateErrorCondition(
                stateEnum: StateEnum.somethingError,
                onTap: () {
                  setState(() {});
                },
              );
            }
            if (snapshot.data!.totalCount == 0) {
              return StateErrorCondition(
                stateEnum: StateEnum.emptyList,
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                },
              );
            }
            RepositoriesModel repositories = snapshot.data!;
            // repository list
            return ListView.separated(
              itemCount:
                  repositories.totalCount! > 10 ? 10 : repositories.totalCount!,
              itemBuilder: (context, index) {
                RepositoryModel repository = repositories.items![index];
                return GestureDetector(
                  onTap: () => navigateToRepositoryScreen(context, repository),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        top: 6, left: 16, right: 16, bottom: 0),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              repository.name,
                              style: const TextStyle(
                                  color: kRepoNameColor, fontSize: 16),
                            ),
                            Text(repository.language!,
                                style: TextStyle(
                                    color: giveLangColor(repository.language!),
                                    fontSize: 13)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (repository.description != null)
                          Text(repository.description!,
                              style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: kDividerColor,
                  thickness: 1,
                );
              },
            );
          }),
    );
  }
}

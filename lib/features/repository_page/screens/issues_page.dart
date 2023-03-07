import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/common/widgets/custom_button.dart';
import 'package:flutter_github/common/widgets/error_state.dart';
import 'package:flutter_github/common/widgets/loader.dart';
import 'package:flutter_github/features/repository_page/services/repository_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/utils/colors.dart';
import 'create_issue_screen.dart';

class IssuePage extends StatefulWidget {
  static const String routeName = '/issues-page';
  final String repoUrl;
  const IssuePage({super.key, required this.repoUrl});

  @override
  State<IssuePage> createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  RepositoryServices repositoryServices = RepositoryServices();

  void navigateToCreateIssuePage() {
    Navigator.pushNamed(context, CreateIssueScreen.routeName,
        arguments: widget.repoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // back arrow button
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: kArrowBackColor,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Issues',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: repositoryServices.fetchIssues(
              context: context, contentUrl: widget.repoUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return StateErrorCondition(
                  stateEnum: StateEnum.connectionError,
                  onTap: () {
                    setState(() {});
                  });
            }
            if (snapshot.data!.isEmpty) {
              return StateErrorCondition(
                  secondButton: true,
                  onSecondTap: () {
                    setState(() {});
                  },
                  stateEnum: StateEnum.emptyList,
                  onTap: () {
                    navigateToCreateIssuePage();
                  });
            }
            final issueContent = snapshot.data!;
            // all issues
            return Stack(
              children: [
                ListView.separated(
                    itemBuilder: (context, index) {
                      // formatted date
                      String createdAt = dateFormat('yyyy-MM-ddThh:mm:ssZ',
                          issueContent[index].createdAt!, 'dd MMM');
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              issueContent[index].title!,
                              style: const TextStyle(
                                  color: kLinkColor, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // issue details
                                Row(
                                  children: [
                                    if (issueContent[index].state! == 'open')
                                      SvgPicture.asset(
                                          'assets/images/point.svg'),
                                    Text(
                                      issueContent[index].state! == 'open'
                                          ? ' Open'
                                          : 'Close',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: issueContent[index].state! ==
                                                  'open'
                                              ? kForkAndQuestionColor
                                              : kErrorColor),
                                    ),
                                  ],
                                ),
                                Text(
                                  createdAt,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: issueContent.length,
                    separatorBuilder: (context, index) => const Divider(
                          thickness: 1,
                          color: kDividerColor,
                        )),
                // create issue button
                Center(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 20),
                      child: CustomButton(
                          text: 'Create new issue',
                          onTap: navigateToCreateIssuePage),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

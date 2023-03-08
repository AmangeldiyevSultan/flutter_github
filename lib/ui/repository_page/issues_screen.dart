import 'package:flutter/material.dart';
import 'package:flutter_github/data/common/utils/utils.dart';
import 'package:flutter_github/data/common/widgets/custom_button.dart';
import 'package:flutter_github/data/common/widgets/error_state.dart';
import 'package:flutter_github/data/common/widgets/loader.dart';
import 'package:flutter_github/data/repositories/repository_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/common/utils/colors.dart';
import 'create_issue_screen.dart';

class IssueScreen extends StatefulWidget {
  static const String routeName = '/issues-page';
  final String repoUrl;
  const IssueScreen({super.key, required this.repoUrl});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
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
        title: Text(
          localization(context).issues,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                                          ? localization(context).open
                                          : localization(context).close,
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
                          text: localization(context).create_new_issue,
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

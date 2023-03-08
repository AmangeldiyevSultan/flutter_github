import 'package:flutter/material.dart';
import 'package:flutter_github/data/common/utils/size_config.dart';
import 'package:flutter_github/data/common/utils/utils.dart';
import 'package:flutter_github/data/common/widgets/custom_button.dart';
import 'package:flutter_github/data/common/widgets/custom_textfield.dart';
import 'package:flutter_github/data/repositories/repository_services.dart';

import '../../data/common/utils/colors.dart';

class CreateIssueScreen extends StatefulWidget {
  static const routeName = '/create-issue';
  final String repoUrl;
  const CreateIssueScreen({super.key, required this.repoUrl});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  final TextEditingController titleContoller = TextEditingController();
  final TextEditingController descriptionContoller = TextEditingController();
  final _createIssueKey = GlobalKey<FormState>();
  RepositoryServices repositoryServices = RepositoryServices();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    titleContoller.dispose();
    descriptionContoller.dispose();
  }

  // create new issue
  void createNewIssue() {
    isLoading = true;
    setState(() {});
    repositoryServices
        .createIssue(
            context: context,
            contentUrl: widget.repoUrl,
            title: titleContoller.text.trim(),
            description: descriptionContoller.text.trim())
        .then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: kArrowBackColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          localization(context).new_issue,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // create issue form
            Form(
                key: _createIssueKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: titleContoller,
                      hintText: localization(context).title,
                      formEnum: FormEnum.issueFrom,
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(32),
                    ),
                    CustomTextField(
                      controller: descriptionContoller,
                      hintText: localization(context).description,
                      formEnum: FormEnum.issueFrom,
                    ),
                  ],
                )),
            const Spacer(),
            //create issue button
            CustomButton(
                isLoading: isLoading,
                text: localization(context).sumbit_new_issue,
                onTap: () {
                  if (_createIssueKey.currentState!.validate()) {
                    createNewIssue();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

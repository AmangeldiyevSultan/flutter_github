import 'package:flutter/material.dart';
import 'package:flutter_github/common/utils/size_config.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/common/widgets/custom_button.dart';
import 'package:flutter_github/common/widgets/custom_textfield.dart';
import 'package:flutter_github/features/repository_page/services/repository_services.dart';

import '../../../common/utils/colors.dart';

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
        title: const Text(
          'New Issue',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                      hintText: 'Title',
                      formEnum: FormEnum.issueFrom,
                    ),
                    SizedBox(
                      height: SizeConfig.getProportionateScreenHeight(32),
                    ),
                    CustomTextField(
                      controller: descriptionContoller,
                      hintText: 'Description',
                      formEnum: FormEnum.issueFrom,
                    ),
                  ],
                )),
            const Spacer(),
            //create issue button
            CustomButton(
                isLoading: isLoading,
                text: 'Submit new issue',
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

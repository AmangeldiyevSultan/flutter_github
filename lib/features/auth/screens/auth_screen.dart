import 'package:flutter/material.dart';
import 'package:flutter_github/data/repositories/auth_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/common/utils/size_config.dart';
import '../../../data/common/utils/utils.dart';
import '../../../data/common/widgets/custom_button.dart';
import '../../../data/common/widgets/custom_textfield.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _tokenController = TextEditingController();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthServices _authServices = AuthServices();
  bool isLoading = false;
  int? statusCode;

  @override
  void dispose() {
    super.dispose();
    _tokenController.dispose();
  }

  void signInUser() async {
    isLoading = true;
    setState(() {});
    _authServices
        .signInUser(
      context: context,
      personalToken: _tokenController.text.trim(),
    )
        .then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(70),
            ),

            //logo
            SvgPicture.asset(
              'assets/images/git_avatar.svg',
            ),
            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(62),
            ),
            // sign in form
            Form(
              key: _signInFormKey,
              child: CustomTextField(
                controller: _tokenController,
                hintText: localization(context).personal_access_token,
                formEnum: FormEnum.signIn,
              ),
            ),
            const Spacer(),
            //sign in button
            CustomButton(
                isLoading: isLoading,
                text: localization(context).sign_in,
                onTap: () {
                  if (_signInFormKey.currentState!.validate()) {
                    signInUser();
                  }
                })
          ],
        ),
      ),
    );
  }
}

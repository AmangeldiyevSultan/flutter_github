import 'package:flutter/material.dart';
import 'package:flutter_github/data/common/utils/size_config.dart';
import 'package:flutter_github/data/common/utils/utils.dart';
import 'package:flutter_github/data/common/widgets/custom_button.dart';
import 'package:flutter_github/data/common/widgets/custom_textfield.dart';
import 'package:flutter_github/data/repositories/auth_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  bool checkOrientation() {
    return (SizeConfig.orientation == Orientation.portrait ||
        MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            //logo

            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(
                  checkOrientation() ? 70 : 0),
            ),
            svgOrientationPicture(),
            SizedBox(
              height: SizeConfig.getProportionateScreenHeight(
                  checkOrientation() ? 62 : 0),
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
            Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                    isLoading: isLoading,
                    text: localization(context).sign_in,
                    onTap: () {
                      if (_signInFormKey.currentState!.validate()) {
                        signInUser();
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget svgOrientationPicture() {
    return checkOrientation()
        ? SvgPicture.asset(
            'assets/images/git_avatar.svg',
          )
        : Expanded(
            child: SvgPicture.asset(
              'assets/images/git_avatar.svg',
            ),
          );
  }
}

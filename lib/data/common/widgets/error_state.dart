import 'package:flutter/cupertino.dart';
import 'package:flutter_github/data/common/utils/colors.dart';
import 'package:flutter_github/data/common/utils/utils.dart';
import 'package:flutter_github/data/common/widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StateErrorCondition extends StatelessWidget {
  final StateEnum stateEnum;
  final VoidCallback onTap;
  final VoidCallback? onSecondTap;
  final bool? secondButton;
  final String? secondText;
  const StateErrorCondition(
      {super.key,
      required this.stateEnum,
      required this.onTap,
      this.secondButton,
      this.onSecondTap,
      this.secondText});

  // error title
  String errorTitle(StateEnum enumState, context) {
    return enumState == StateEnum.connectionError
        ? localization(context).connection_error
        : enumState == StateEnum.somethingError
            ? localization(context).something_error
            : enumState == StateEnum.loadError
                ? localization(context).load_error
                : localization(context).empty;
  }

  // error subtitle
  String errorSubtitle(StateEnum enumState, context) {
    return enumState == StateEnum.connectionError ||
            enumState == StateEnum.loadError
        ? localization(context).check_your_internet_connection
        : enumState == StateEnum.somethingError
            ? localization(context).check_your_something
            : localization(context).no_repositories_at_the_moment;
  }

  // set svg format picture
  String svgPictureState(StateEnum enumState) {
    return enumState == StateEnum.connectionError ||
            enumState == StateEnum.loadError
        ? 'assets/images/connection_error.svg'
        : enumState == StateEnum.somethingError
            ? 'assets/images/error.svg'
            : 'assets/images/empty.svg';
  }

  // main button text
  String firstButtonState(StateEnum enumState, context) {
    return enumState == StateEnum.connectionError ||
            enumState == StateEnum.somethingError
        ? localization(context).retry
        : enumState == StateEnum.loadError
            ? localization(context).refresh
            : localization(context).create_new_issue;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SvgPicture.asset(svgPictureState(stateEnum)),
          ),
          //title
          Text(
            errorTitle(stateEnum, context),
            style: TextStyle(
                color: stateEnum == StateEnum.emptyList
                    ? kEmptyColor
                    : kErrorColor,
                fontSize: 16),
          ),
          //subtitle
          Text(
            errorSubtitle(stateEnum, context),
          ),
          const Spacer(),
          //buttons form
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
                child: CustomButton(
                  text: firstButtonState(stateEnum, context),
                  onTap: onTap,
                ),
              ),
              if (secondButton!)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40, right: 16, left: 16),
                  child: CustomButton(
                    color: kBackgroundColor,
                    text: stateEnum == StateEnum.emptyList
                        ? localization(context).refresh
                        : localization(context).retry,
                    onTap: onSecondTap!,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

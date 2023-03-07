import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/common/widgets/custom_button.dart';
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
  String errorTitle(StateEnum enumState) {
    return enumState == StateEnum.connectionError
        ? 'Connection error'
        : enumState == StateEnum.somethingError
            ? 'Something Error'
            : enumState == StateEnum.loadError
                ? 'Load error'
                : 'Empty';
  }

  // error subtitle
  String errorSubtitle(StateEnum enumState) {
    return enumState == StateEnum.connectionError ||
            enumState == StateEnum.loadError
        ? 'Check your Internet connection'
        : enumState == StateEnum.somethingError
            ? 'Check your something'
            : 'No repositories at the moment';
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
  String firstButtonState(StateEnum enumState) {
    return enumState == StateEnum.connectionError ||
            enumState == StateEnum.somethingError
        ? 'Retry'
        : enumState == StateEnum.loadError
            ? 'Refresh'
            : 'Create new issue';
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
            errorTitle(stateEnum),
            style: TextStyle(
                color: stateEnum == StateEnum.emptyList
                    ? kEmptyColor
                    : kErrorColor,
                fontSize: 16),
          ),
          //subtitle
          Text(
            errorSubtitle(stateEnum),
          ),
          const Spacer(),
          //buttons form
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
                child: CustomButton(
                  text: firstButtonState(stateEnum),
                  onTap: onTap,
                ),
              ),
              if (secondButton!)
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40, right: 16, left: 16),
                  child: CustomButton(
                    color: kBackgroundColor,
                    text:
                        stateEnum == StateEnum.emptyList ? 'Refresh' : 'Retry',
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

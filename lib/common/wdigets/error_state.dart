import 'package:flutter/cupertino.dart';
import 'package:flutter_github/common/utils/colors.dart';
import 'package:flutter_github/common/utils/utils.dart';
import 'package:flutter_github/common/wdigets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StateErrorCondition extends StatelessWidget {
  final StateEnum stateEnum;
  final VoidCallback onTap;
  final VoidCallback? onSecondTap;
  final int? buttons;
  final String? secondText;
  const StateErrorCondition(
      {super.key,
      required this.stateEnum,
      required this.onTap,
      this.buttons,
      this.onSecondTap,
      this.secondText});

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
            child: stateEnum == StateEnum.connectionError ||
                    stateEnum == StateEnum.loadError
                ? SvgPicture.asset('assets/images/connection_error.svg')
                : stateEnum == StateEnum.somethingError
                    ? SvgPicture.asset('assets/images/error.svg')
                    : SvgPicture.asset('assets/images/empty.svg'),
          ),
          Text(
            stateEnum == StateEnum.connectionError
                ? 'Connection error'
                : stateEnum == StateEnum.somethingError
                    ? 'Something Error'
                    : stateEnum == StateEnum.loadError
                        ? 'Load error'
                        : 'Empty',
            style: TextStyle(
                color: stateEnum == StateEnum.emptyList
                    ? kEmptyColor
                    : kErrorColor,
                fontSize: 16),
          ),
          Text(
            stateEnum == StateEnum.connectionError ||
                    stateEnum == StateEnum.loadError
                ? 'Check your Internet connection'
                : stateEnum == StateEnum.somethingError
                    ? 'Check your something'
                    : 'No repositories at the moment',
          ),
          const Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 16, left: 16),
                child: CustomButton(
                  text: 'Create new issue',
                  onTap: onTap,
                ),
              ),
              if (buttons == 2)
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

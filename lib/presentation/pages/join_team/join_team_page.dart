import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/form/sportly_pin_input.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';
import 'package:sportly/presentation/widgets/sportly_card.dart';

class JoinTeamPage extends StatelessWidget {
  const JoinTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: (Center(
          child: SportlyCard(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimens.big,
              horizontal: AppDimens.sm,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.join_team_title.tr(),
                  style: AppTypo.titleSmall,
                  textAlign: TextAlign.center,
                ),
                const Gap(AppDimens.lg),
                const SportlyPinInput(),
                const Gap(AppDimens.xlg),
                SportlyButton.solid(
                  label: LocaleKeys.join_team_button_label.tr(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

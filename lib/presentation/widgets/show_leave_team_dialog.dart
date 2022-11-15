import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/show_sportly_dialog.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';

Future<void> showLeaveTeamDialog(
  BuildContext context,
  String teamName,
  Function leaveTeam,
) {
  return showSportlyDialog(
    context,
    RichText(
      text: TextSpan(
        text: LocaleKeys.leave_team_message.tr(),
        style: AppTypo.bodyMedium.copyWith(
          fontFamily: 'Montserrat',
        ),
        children: [
          TextSpan(
            text: teamName,
            style: AppTypo.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const TextSpan(text: '?')
        ],
      ),
    ),
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(AppDimens.big),
        SportlyButton.solid(
          label: LocaleKeys.leave_team_cancel.tr(),
          onTap: Navigator.of(context, rootNavigator: true).pop,
        ),
        const Gap(AppDimens.xsm),
        SportlyButton.danger(
          label: LocaleKeys.leave_team_confirm.tr(),
          onTap: () {
            try {
              leaveTeam();
              showSnackBar(context, 'You left $teamName');
            } catch (e) {
              showSnackBar(context, 'Could not leave $teamName');
            } finally {
              Navigator.of(context, rootNavigator: true).pop();
              context.router.navigate(const TeamsRouter());
            }
          },
        ),
      ],
    ),
  );
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/show_snackbar.dart';
import 'package:sportly/presentation/widgets/show_sportly_dialog.dart';
import 'package:sportly/presentation/widgets/sportly_button.dart';

Future<void> showDeleteEventDialog(
  BuildContext context,
  String eventName,
  Function deleteEvent,
) {
  return showSportlyDialog(
    context,
    RichText(
      text: TextSpan(
        text: 'Are you sure you want to delete ',
        style: AppTypo.bodyMedium.copyWith(
          fontFamily: 'Montserrat',
        ),
        children: [
          TextSpan(
            text: eventName,
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
          label: 'Cancel',
          onTap: Navigator.of(context, rootNavigator: true).pop,
        ),
        const Gap(AppDimens.xsm),
        SportlyButton.danger(
          label: 'Delete',
          onTap: () {
            try {
              deleteEvent();
              showSnackBar(
                context,
                '$eventName deleted',
                SnackbarPurpose.info,
              );
            } catch (e) {
              showSnackBar(
                context,
                'Could not delete $eventName',
                SnackbarPurpose.error,
              );
            } finally {
              Navigator.of(context, rootNavigator: true).pop();
              // context.router.navigate(const TeamsRouter());
            }
          },
        ),
      ],
    ),
  );
}

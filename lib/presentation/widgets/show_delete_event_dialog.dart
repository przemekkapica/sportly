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
        text: LocaleKeys.delete_event_dialog_question.tr(),
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
          label: LocaleKeys.delete_event_dialog_cancel.tr(),
          onTap: Navigator.of(context, rootNavigator: true).pop,
        ),
        const Gap(AppDimens.xsm),
        SportlyButton.danger(
          label: LocaleKeys.delete_event_dialog_confirm.tr(),
          onTap: () {
            try {
              deleteEvent();
              showSnackBar(
                context,
                LocaleKeys.delete_event_dialog_success.tr(args: [eventName]),
                SnackbarPurpose.info,
              );
            } catch (e) {
              showSnackBar(
                context,
                LocaleKeys.delete_event_dialog_error.tr(args: [eventName]),
                SnackbarPurpose.error,
              );
            } finally {
              Navigator.of(context, rootNavigator: true).pop();
            }
          },
        ),
      ],
    ),
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyError extends StatelessWidget {
  const SportlyError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sentiment_very_dissatisfied_rounded,
            size: AppDimens.xxxlg,
          ),
          const Gap(AppDimens.sm),
          Text(
            LocaleKeys.error_state_title.tr(),
            style: AppTypo.titleSmall,
            textAlign: TextAlign.center,
          ),
          const Gap(AppDimens.sm),
          Text(
            LocaleKeys.error_state_description.tr(),
            style: AppTypo.bodySmall,
          )
        ],
      ),
    );
  }
}

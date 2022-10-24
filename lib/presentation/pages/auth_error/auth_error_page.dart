import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class AuthErrorPage extends StatelessWidget {
  const AuthErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimens.xxxlg,
            ),
            const Gap(AppDimens.sm),
            Text(
              LocaleKeys.auth_error_page_title.tr(),
              style: AppTypo.titleSmall,
              textAlign: TextAlign.center,
            ),
            const Gap(AppDimens.sm),
            Text(
              LocaleKeys.auth_error_page_description.tr(),
              style: AppTypo.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}

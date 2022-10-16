import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_assets.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/widgets/app_logo.dart';
import 'package:sportly/presentation/widgets/primary_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.sm),
        child: Column(
          children: [
            const Spacer(),
            const AppLogo(),
            const Spacer(),
            PrimaryButton.solid(
              label: LocaleKeys.sign_in_page_button_label.tr(),
              assetPath: AppAssets.googleIcon,
              onTap: () {},
            ),
            const Gap(AppDimens.md),
          ],
        ),
      ),
    );
  }
}

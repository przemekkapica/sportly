import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/widgets/primary_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton.solid(
              label: LocaleKeys.sign_in_page_button_label.tr(),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

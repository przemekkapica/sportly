import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_statusbar_connected_no_internet_4_rounded,
              size: AppDimens.xxxlg,
            ),
            const Gap(AppDimens.sm),
            Text(
              LocaleKeys.offline_page_title.tr(),
              style: AppTypo.titleSmall,
            ),
            const Gap(AppDimens.xsm),
            Text(
              LocaleKeys.offline_page_description.tr(),
              style: AppTypo.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

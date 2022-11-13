import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class SportlyDivider extends StatelessWidget {
  const SportlyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: AppDimens.one,
      color: AppColors.secondary.withAlpha(90),
    );
  }
}

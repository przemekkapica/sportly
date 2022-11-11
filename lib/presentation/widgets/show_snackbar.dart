import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.additional1,
      duration: const Duration(seconds: 2),
      content: Text(
        message,
        style: AppTypo.labelLarge.copyWith(
          color: AppColors.neutral,
          fontFamily: 'Montserrat',
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

enum SnackbarPurpose {
  info,
  error,
  success,
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context,
  String message,
  SnackbarPurpose purpose,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: getColor(purpose),
      duration: const Duration(seconds: 3),
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

Color getColor(SnackbarPurpose purpose) {
  switch (purpose) {
    case SnackbarPurpose.info:
      return AppColors.additional1;
    case SnackbarPurpose.error:
      return AppColors.danger;
    case SnackbarPurpose.success:
      return AppColors.succeess;
  }
}

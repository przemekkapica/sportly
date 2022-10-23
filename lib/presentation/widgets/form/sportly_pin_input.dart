import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyPinInput extends StatelessWidget {
  const SportlyPinInput({
    Key? key,
    this.length,
  }) : super(key: key);

  final int? length;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = DefaultPinputTheme();

    return Pinput(
      length: length ?? 6,
      autofocus: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.withColor(AppColors.primary),
      errorPinTheme: defaultPinTheme.withColor(AppColors.danger),
      submittedPinTheme: defaultPinTheme.withColor(AppColors.secondary),
    );
  }
}

class DefaultPinputTheme extends PinTheme {
  DefaultPinputTheme({
    EdgeInsetsGeometry margin =
        const EdgeInsets.symmetric(horizontal: AppDimens.xxsm),
  }) : super(
          width: 46,
          height: 52,
          textStyle: AppTypo.bodyMedium,
          margin: margin,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondary.withAlpha(80)),
            borderRadius: BorderRadius.circular(AppDimens.xsm),
          ),
        );

  PinTheme withColor(Color color) {
    assert(decoration != null);

    return copyWith(
      decoration: decoration?.copyWith(border: Border.all(color: color)),
    );
  }
}

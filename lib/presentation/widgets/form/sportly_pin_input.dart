import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyPinInput extends StatelessWidget {
  const SportlyPinInput({
    Key? key,
    this.length,
    required this.errorText,
    required this.onChanged,
    this.onCompleted,
  }) : super(key: key);

  final int? length;
  final String errorText;
  final Function(String)? onCompleted;
  final Function(String)? onChanged;

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
      onCompleted: onCompleted,
      onChanged: onChanged,
      errorText: errorText,
      forceErrorState: errorText.isNotEmpty,
    );
  }
}

class DefaultPinputTheme extends PinTheme {
  DefaultPinputTheme({
    EdgeInsetsGeometry margin =
        const EdgeInsets.symmetric(horizontal: AppDimens.xxsm),
  }) : super(
          width: 52,
          height: 52,
          textStyle: AppTypo.bodyLarge,
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

import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyTextInput extends StatelessWidget {
  const SportlyTextInput({
    Key? key,
    required this.label,
    required this.textInputAction,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTypo.bodySmall.copyWith(color: AppColors.primary),
      cursorColor: AppColors.secondary,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: AppColors.neutral,
        filled: true,
        labelText: label,
        floatingLabelStyle:
            AppTypo.labelLarge.copyWith(color: AppColors.primary),
        labelStyle: AppTypo.bodySmall,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimens.one,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.secondary.withAlpha(80),
            width: AppDimens.one,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.danger,
            width: AppDimens.one,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppDimens.xxxsm,
          ),
        ),
        focusColor: AppColors.primary,
        hoverColor: AppColors.primary,
      ),
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}

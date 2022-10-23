import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyDropdown extends StatelessWidget {
  const SportlyDropdown({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.items,
  }) : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>>? items;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButtonFormField<String>(
        value: null,
        elevation: 1,
        decoration: InputDecoration(
          fillColor: AppColors.neutral,
          filled: true,
          floatingLabelStyle: AppTypo.labelLarge.copyWith(
            color: AppColors.primary,
          ),
          labelStyle: AppTypo.bodySmall.copyWith(
            color: AppColors.primary,
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
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(AppDimens.borderRadius),
            ),
            borderSide: BorderSide(
              color: AppColors.secondary.withAlpha(100),
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
          focusedBorder: const OutlineInputBorder(
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
          hintStyle: AppTypo.bodySmall,
          hintText: hintText,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          // setState(() {
          //   dropdownValue = value!;
          // });
        },
        validator: validator,
        items: items,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class SportlyCard extends StatelessWidget {
  const SportlyCard({
    Key? key,
    required this.content,
    this.borderColor,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final Widget content;
  final Function()? onTap;
  final Color? borderColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.neutral,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.borderRadius),
          ),
          border: Border.all(
            color: borderColor ?? AppColors.additional3,
            width: 1,
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppDimens.sm),
          child: content,
        ),
      ),
    );
  }
}

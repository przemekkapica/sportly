import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class SportlyIconButton extends StatelessWidget {
  const SportlyIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
            width: AppDimens.one,
          ),
          color: AppColors.neutral,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.xxsm),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppDimens.xxsm),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.xsm),
            child: Icon(
              icon,
              size: AppDimens.iconButtonSize,
            ),
          ),
        ),
      ),
    );
  }
}

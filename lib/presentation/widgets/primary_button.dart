import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

enum ButtonType {
  solid,
  outlined,
  danger,
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton.solid({
    Key? key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.solid,
    this.enabled = true,
    this.color = AppColors.buttonFill,
    this.textColor = AppColors.buttonText,
    this.disabledTextColor = AppColors.disabledButtonText,
    this.assetPath,
  }) : super(key: key);

  const PrimaryButton.outlined({
    Key? key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.outlined,
    this.enabled = true,
    this.color = AppColors.outlinedButtonFill,
    this.textColor = AppColors.outlinedButtonText,
    this.disabledTextColor = AppColors.disabledButtonText,
    this.assetPath,
  }) : super(key: key);

  const PrimaryButton.danger({
    Key? key,
    required this.label,
    required this.onTap,
    this.type = ButtonType.danger,
    this.enabled = true,
    this.color = AppColors.dangerButtonFill,
    this.textColor = AppColors.dangerButtonText,
    this.disabledTextColor = AppColors.disabledButtonText,
    this.assetPath,
  }) : super(key: key);

  final String label;
  final VoidCallback? onTap;
  final ButtonType type;
  final bool enabled;
  final Color? color;
  final Color? textColor;
  final Color? disabledTextColor;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onTap : null,
      style: ButtonStyle(
        alignment: Alignment.center,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStateProperty.all(const EdgeInsets.all(AppDimens.big)),
        backgroundColor: MaterialStateProperty.resolveWith(
          (s) => _isEnabled(s) ? color : _getDisabledColor(),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.zero),
            side: _getBorderSide(),
          ),
        ),
        overlayColor: _getOverlayColor(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (assetPath != null) ...[
            Image(
              image: AssetImage(assetPath!),
              width: AppDimens.xbig,
              height: AppDimens.xbig,
            ),
            const Gap(AppDimens.xsm),
          ],
          Text(
            label,
            style: _getTextStyle(),
          ),
        ],
      ),
    );
  }

  MaterialStateProperty<Color?> _getOverlayColor() {
    switch (type) {
      case ButtonType.solid:
        return MaterialStateProperty.all(
          AppColors.additional1.withAlpha(120),
        );
      case ButtonType.outlined:
        return MaterialStateProperty.all(
          AppColors.primary.withAlpha(20),
        );
      case ButtonType.danger:
        return MaterialStateProperty.all(
          AppColors.danger.withAlpha(20),
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (type) {
      case ButtonType.solid:
        return AppTypo.button.copyWith(
          color: enabled ? AppColors.neutral : AppColors.disabledButtonText,
        );
      case ButtonType.outlined:
        return AppTypo.button.copyWith(
          color: enabled ? AppColors.primary : AppColors.disabledButtonText,
        );
      case ButtonType.danger:
        return AppTypo.button.copyWith(
          color: enabled
              ? AppColors.dangerButtonText
              : AppColors.dangerButtonText.withAlpha(100),
        );
    }
  }

  bool _isEnabled(Set<MaterialState> states) =>
      states.contains(MaterialState.disabled) == false;

  BorderSide _getBorderSide() {
    switch (type) {
      case ButtonType.solid:
        return BorderSide.none;
      case ButtonType.outlined:
        return BorderSide(
          width: AppDimens.xxxsm,
          color: enabled
              ? AppColors.outlinedButtonBorder
              : AppColors.disabledButtonBorder,
        );
      case ButtonType.danger:
        return BorderSide(
          width: AppDimens.xxxsm,
          color: enabled
              ? AppColors.dangerButtonBorder
              : AppColors.dangerButtonBorder.withAlpha(100),
        );
    }
  }

  Color _getDisabledColor() {
    switch (type) {
      case ButtonType.solid:
        return AppColors.disabledButtonFill;
      case ButtonType.outlined:
        return AppColors.neutral;
      case ButtonType.danger:
        return AppColors.neutral;
    }
  }
}

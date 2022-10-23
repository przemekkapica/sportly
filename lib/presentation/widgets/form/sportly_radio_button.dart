import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyRadioButton<T> extends StatelessWidget {
  const SportlyRadioButton({
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final T value;
  final T? groupValue;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(
            unselectedWidgetColor: AppColors.additional1,
          ),
          child: SizedBox(
            height: 20,
            width: 20,
            child: Radio<T>(
              value: value,
              groupValue: groupValue,
              activeColor: AppColors.additional1,
              overlayColor: MaterialStateProperty.all(AppColors.secondary),
              fillColor: MaterialStateProperty.all(AppColors.primary),
              onChanged: onChanged,
            ),
          ),
        ),
        const Gap(AppDimens.xsm),
        Text(
          label,
          style: AppTypo.labelLarge,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';

class SportlyCard extends StatelessWidget {
  const SportlyCard({
    Key? key,
    required this.content,
  }) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.neutral,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimens.sm),
        ),
        border: Border.all(
          color: AppColors.additional3,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.sm),
        child: content,
      ),
    );
  }
}

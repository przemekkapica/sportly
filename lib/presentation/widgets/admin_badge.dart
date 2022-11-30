import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class AdminBadge extends StatelessWidget {
  const AdminBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.borderRadius),
        ),
        color: AppColors.secondary,
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.xxsm, horizontal: 6),
        child: Text(
          'ADMIN',
          style: AppTypo.badge,
        ),
      ),
    );
  }
}

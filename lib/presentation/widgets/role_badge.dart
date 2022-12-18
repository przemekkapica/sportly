import 'package:flutter/material.dart';
import 'package:sportly/domain/features/teams/models/role.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class RoleBadge extends StatelessWidget {
  const RoleBadge({
    super.key,
    required this.role,
  });

  final Role role;

  @override
  Widget build(BuildContext context) {
    final isAdmin = role == Role.admin || role == Role.proAdmin;
    final isAssistant = role == Role.assistant;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimens.borderRadius),
        ),
        color: AppColors.secondary,
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppDimens.xxsm, horizontal: 6),
        child: Text(
          isAdmin
              ? 'ADMIN'
              : isAssistant
                  ? 'ASSISTANT'
                  : '',
          style: AppTypo.badge,
        ),
      ),
    );
  }
}

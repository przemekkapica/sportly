import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';

class SportlyBottomBar extends StatelessWidget {
  const SportlyBottomBar({
    Key? key,
    required this.tabsRouter,
  }) : super(key: key);

  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SalomonBottomBar(
        selectedItemColor: AppColors.primary,
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.spoke_rounded,
              size: AppDimens.bottomBarIconSize,
            ),
            title: Text(
              LocaleKeys.bottom_bar_teams.tr(),
              style: AppTypo.bottomBar,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.chat,
              size: AppDimens.bottomBarIconSize,
            ),
            title: Text(
              LocaleKeys.bottom_bar_chat.tr(),
              style: AppTypo.bottomBar,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.calendar_month_rounded,
              size: AppDimens.bottomBarIconSize,
            ),
            title: Text(
              LocaleKeys.bottom_bar_schedule.tr(),
              style: AppTypo.bottomBar,
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              Icons.account_circle,
              size: AppDimens.bottomBarIconSize,
            ),
            title: Text(
              LocaleKeys.bottom_bar_profile.tr(),
              style: AppTypo.bottomBar,
            ),
          ),
        ],
      ),
    );
  }
}

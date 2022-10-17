import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sportly/presentation/gen/local_keys.g.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/theme/app_typo.dart';
import 'package:sportly/presentation/widgets/horizontal_app_logo.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        TeamsPageRoute(),
        ChatPageRoute(),
        SchedulePageRoute(),
        ProfilePageRoute(),
      ],
      backgroundColor: AppColors.neutral,
      appBarBuilder: (_, tabsRouter) => AppBar(
        backgroundColor: AppColors.neutral,
        title: const HorizontalAppLogo(),
        centerTitle: true,
        toolbarHeight: AppDimens.appBarHeight,
      ),
      bottomNavigationBuilder: (_, tabsRouter) {
        return SalomonBottomBar(
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
                style: AppTypo.labelLarge,
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.chat,
                size: AppDimens.bottomBarIconSize,
              ),
              title: Text(
                LocaleKeys.bottom_bar_chat.tr(),
                style: AppTypo.labelLarge,
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.calendar_month_rounded,
                size: AppDimens.bottomBarIconSize,
              ),
              title: Text(
                LocaleKeys.bottom_bar_schedule.tr(),
                style: AppTypo.labelLarge,
              ),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.account_circle,
                size: AppDimens.bottomBarIconSize,
              ),
              title: Text(
                LocaleKeys.bottom_bar_profile.tr(),
                style: AppTypo.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}

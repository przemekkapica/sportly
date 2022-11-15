import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sportly/presentation/theme/app_colors.dart';
import 'package:sportly/presentation/theme/app_dimens.dart';
import 'package:sportly/presentation/widgets/horizontal_app_logo.dart';

class SportlyAppBar extends StatelessWidget with PreferredSizeWidget {
  const SportlyAppBar({
    Key? key,
    this.showBackButton = false,
  }) : super(key: key);

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.neutral,
      title: const HorizontalAppLogo(),
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
              onPressed: context.router.popTop,
            )
          : const SizedBox.shrink(),
      toolbarHeight: AppDimens.appBarHeight,
      shadowColor: AppColors.background,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}

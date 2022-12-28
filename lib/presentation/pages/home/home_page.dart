import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/pages/home/home_page_cubit.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/widgets/sportly_app_bar.dart';
import 'package:sportly/presentation/widgets/sportly_bottom_bar.dart';

const _backButtonPaths = [
  '/',
  '/teams',
  '/chat',
  '/schedule',
  '/profile',
];

const _teamIndicatorPaths = [
  '/',
  '/teams',
  '/teams/details',
  '/teams/manage',
  '/teams/share',
  '/chat',
  '/schedule',
  '/profile',
];

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<HomePageCubit>();
    final state = useCubitBuilder(cubit);

    return AutoTabsRouter(
      routes: const [
        TeamsRouter(),
        ChatRouter(),
        ScheduleRouter(),
        ProfilePageRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: SportlyAppBar(
            showBackButton: !_backButtonPaths.contains(
              context.router.currentPath,
            ),
            showTeamIndicator: !_teamIndicatorPaths.contains(
              context.router.currentPath,
            ),
            selectedTeam: context.router.currentPath.contains('schedule')
                ? state.selectedScheduleTeam
                : state.selectedChatTeam,
          ),
          body: child,
          bottomNavigationBar: SportlyBottomBar(tabsRouter: tabsRouter),
        );
      },
    );
  }
}

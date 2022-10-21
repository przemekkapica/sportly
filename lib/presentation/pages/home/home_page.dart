import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';
import 'package:sportly/presentation/widgets/sportly_app_bar.dart';
import 'package:sportly/presentation/widgets/sportly_bottom_bar.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        TeamsPageRouter(),
        ChatPageRoute(),
        SchedulePageRoute(),
        ProfilePageRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: const SportlyAppBar(),
          body: child,
          bottomNavigationBar: SportlyBottomBar(tabsRouter: tabsRouter),
        );
      },
    );
  }
}

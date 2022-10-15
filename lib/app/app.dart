import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/app/app_action.f.dart';
import 'package:sportly/app/app_cubit.dart';
import 'package:sportly/core/di/di_config.dart';
import 'package:sportly/domain/features/network/connectivity/connection_checker.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

class App extends HookWidget {
  const App({
    Key? key,
    required this.mainRouter,
  }) : super(key: key);

  final MainRouter mainRouter;

  @override
  Widget build(BuildContext context) {
    final connectionChecker = useMemoized(() => getIt.get<ConnectionChecker>());
    final cubit = useCubit<AppCubit>();

    useActionListener<AppAction>(
      cubit,
      (action) {
        action.map(
          offline: (_) {
            mainRouter.navigate(
              const OfflinePageRoute(),
            );
          },
          online: (_) {
            mainRouter.popUntil(
              (route) => route.settings.name != OfflinePageRoute.name,
            );
          },
        );
      },
    );

    useEffect(
      () {
        connectionChecker.startServerPing();
      },
      [],
    );

    useOnAppLifecycleStateChange((previous, current) {
      if (current == AppLifecycleState.resumed) {
        connectionChecker.startServerPing();
      } else {
        connectionChecker.stopServerPing();
      }
    });

    return _MaterialApp(mainRouter: mainRouter);
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp({
    Key? key,
    required this.mainRouter,
  }) : super(key: key);

  final MainRouter mainRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: mainRouter.delegate(),
      routeInformationParser: mainRouter.defaultRouteParser(),
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      builder: (context, routerWidget) {
        if (routerWidget == null) {
          return const SizedBox.shrink();
        }

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: routerWidget,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.mainRouter,
  }) : super(key: key);

  final MainRouter mainRouter;

  @override
  Widget build(BuildContext context) {
    return _MaterialApp(
      mainRouter: mainRouter,
    );
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

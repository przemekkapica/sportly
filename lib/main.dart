import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/app/app.dart';
import 'package:sportly/core/di/di_config.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  configureInjection();
  _initializeHookedBloc();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('pl')],
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: App(mainRouter: MainRouter()),
    ),
  );
}

void _initializeHookedBloc() {
  HookedBloc.initialize(() => getIt);
}

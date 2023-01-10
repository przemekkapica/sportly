import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/presentation/app/app.dart';
import 'package:sportly/core/di/di_config.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  configureInjection();
  _initializeHookedBloc();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await _initializeCrashlytics();

  await runZonedGuarded(
    () async {
      runApp(
        EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale('en'), Locale('pl')],
          startLocale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          child: App(mainRouter: MainRouter()),
        ),
      );
    },
    (e, st) {
      log('main runApp', error: e, stackTrace: st);
    },
  );
}

Future<void> _initializeCrashlytics() async {
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

void _initializeHookedBloc() {
  HookedBloc.initialize(() => getIt);
}

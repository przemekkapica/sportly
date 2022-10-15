import 'package:flutter/material.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:sportly/app/app.dart';
import 'package:sportly/core/di/di_config.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

void main() {
  configureInjection();
  _initializeHookedBloc();

  runApp(App(mainRouter: MainRouter()));
}

void _initializeHookedBloc() {
  HookedBloc.initialize(() => getIt);
}

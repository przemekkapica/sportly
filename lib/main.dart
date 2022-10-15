import 'package:flutter/material.dart';
import 'package:sportly/app/app.dart';
import 'package:sportly/presentation/routing/main_router.dart';
import 'package:sportly/presentation/routing/main_router.gr.dart';

void main() {
  runApp(App(mainRouter: MainRouter()));
}

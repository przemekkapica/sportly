// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:sportly/presentation/pages/teams_page/teams_page.dart' as _i1;

class MainRouter extends _i2.RootStackRouter {
  MainRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    TeamsPageRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.TeamsPage(),
        opaque: true,
      );
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          TeamsPageRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [_i1.TeamsPage]
class TeamsPageRoute extends _i2.PageRouteInfo<void> {
  const TeamsPageRoute()
      : super(
          TeamsPageRoute.name,
          path: '/',
        );

  static const String name = 'TeamsPageRoute';
}
